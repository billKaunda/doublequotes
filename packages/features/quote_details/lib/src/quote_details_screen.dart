import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'quote_details_cubit.dart';
import 'l10n/quote_details_localizations.dart';

typedef QuoteDetailsShareableLinkGenerator = Future<String> Function(
    Quote quote);

class QuoteDetailsScreen extends StatelessWidget {
  const QuoteDetailsScreen({
    super.key,
    required this.quoteId,
    required this.onAuthenticationError,
    required this.quoteRepository,
    this.userRepository,
    this.shareableLinkGenerator,
  });

  final int quoteId;
  final VoidCallback onAuthenticationError;
  final QuoteRepository quoteRepository;
  final UserRepository? userRepository;
  final QuoteDetailsShareableLinkGenerator? shareableLinkGenerator;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteDetailsCubit>(
      create: (_) => QuoteDetailsCubit(
        quoteId: quoteId,
        quoteRepository: quoteRepository,
      ),
      child: QuoteDetailsView(
        onAuthenticationError: onAuthenticationError,
        shareableLinkGenerator: shareableLinkGenerator,
        userRepository: userRepository,
      ),
    );
  }
}

@visibleForTesting
class QuoteDetailsView extends StatelessWidget {
  const QuoteDetailsView({
    super.key,
    required this.onAuthenticationError,
    this.shareableLinkGenerator,
    this.userRepository,
  });

  final VoidCallback onAuthenticationError;
  final QuoteDetailsShareableLinkGenerator? shareableLinkGenerator;
  final UserRepository? userRepository;

  @override
  Widget build(BuildContext context) {
    final l10n = QuoteDetailsLocalizations.of(context);
    final screenMargin =
        (WallpaperDoubleQuotesTheme.maybeOf(context)?.screenMargin ??
                DefaultDoubleQuotesTheme.maybeOf(context)?.screenMargin) ??
            Spacing.mediumLarge;

    return StyledStatusBar.dark(
      child: BlocConsumer<QuoteDetailsCubit, QuoteDetailsState>(
        // Biggest driver here is that a user has to be signed in to
        // perform actions on the _QuoteActionsAppBar such as upvoting
        // a quote or downvoting.
        listener: (context, state) {
          final quoteUpdateError =
              state is QuoteDetailsSuccess ? state.quoteUpdateError : null;
          if (quoteUpdateError != null) {
            final snackBar = switch (quoteUpdateError) {
              UserSessionNotFound _ =>
                const AuthenticationRequiredErrorSnackBar(),
              CannotUnfavPrivateQuotes _ => SnackBar(
                  content: Text(l10n.cannotUnfavPrivateQuoteErrorMessage),
                ),
              ProUserRequired _ => SnackBar(
                  content: Text(l10n.proUserRequiredErrorMessage),
                ),
              CouldNotCreateQuote _ => SnackBar(
                  content: Text(l10n.couldNotCreateQuoteErrorMessage),
                ),
              _ => const GenericErrorSnackBar(),
            };

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

            // send the user to the sign-in screen by using the
            // onAuthenticationError callback received in the constructor.
            if (quoteUpdateError is UserSessionNotFound) {
              onAuthenticationError();
            }
          }
        },
        //Function of the builder property is just to return widgets, not
        // execute actions.
        builder: (context, state) {
          //The PopScope widget allows you to intercept when the user tries
          // to navigate back from the screen. This is used to send the
          // current quote to the home screen if the current state is a
          // QuoteDetailsSuccess. This is done so as to inform the previous
          // screen if the user has performed actions on that quote, such as
          // favouriting or unfavouriting, & reflect the changes accordingly
          return PopScope(
            onPopInvokedWithResult: (_, result) {
              final displayedQuote =
                  state is QuoteDetailsSuccess ? state.quote : null;
              return Navigator.of(context).pop(displayedQuote);
            },
            canPop: false, //Disable back gesture
            child: Scaffold(
              appBar: state is QuoteDetailsSuccess
                  ? _QuoteActionsAppBar(
                      quote: state.quote,
                      shareableLinkGenerator: shareableLinkGenerator,
                    )
                  : null,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(screenMargin),
                  child: state is QuoteDetailsSuccess
                      ? _Quote(
                          quote: state.quote,
                          l10n: l10n,
                          userRepository: userRepository,
                        )
                      : state is QuoteDetailsFailure
                          ? ExceptionIndicator(
                              title: l10n.quoteNotFoundErrorMessageTitle,
                              message: l10n.quoteNotFoundErrorMessageBody,
                              onTryAgain: () {
                                //BlocBuilder gives you that state object inside
                                // the builder, but not the actual Cubit. To
                                // call a function or send an event to the
                                // cubit, you access the instance of the cubit
                                // via context.read<CubitType>.
                                final cubit = context.read<QuoteDetailsCubit>();
                                cubit.refetch();
                              },
                            )
                          : const CenteredCircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _QuoteActionsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _QuoteActionsAppBar({
    required this.quote,
    this.shareableLinkGenerator,
  });

  final Quote quote;
  final QuoteDetailsShareableLinkGenerator? shareableLinkGenerator;

  @override
  Widget build(BuildContext context) {
    final l10n = QuoteDetailsLocalizations.of(context);
    final cubit = context.read<QuoteDetailsCubit>();
    final shareableLinkGenerator = this.shareableLinkGenerator;

    return RowAppBar(
      children: [
        FavoriteIconButton(
          isFavorite: quote.userDetails?.isFavorite ?? false,
          onTap: () {
            if (quote.userDetails!.isFavorite == true) {
              cubit.unfavoriteQuote();
            } else {
              cubit.favoriteQuote();
            }
          },
        ),
        UpvoteIconButton(
          count: quote.upvotesCount ?? 0,
          isUpvoted: quote.userDetails?.isUpvoted ?? false,
          onTap: () {
            if (quote.userDetails?.isUpvoted == true) {
              cubit.clearvoteOnQuote();
            } else {
              cubit.upvoteQuote();
            }
          },
        ),
        DownvoteIconButton(
          count: quote.downvotesCount ?? 0,
          isDownvoted: quote.userDetails?.isDownvoted ?? false,
          onTap: () {
            if (quote.userDetails!.isDownvoted == true) {
              cubit.clearvoteOnQuote();
            } else {
              cubit.downvoteQuote();
            }
          },
        ),
        HideIconButton(
          isHidden: quote.userDetails!.isHidden ?? false,
          onTap: () {
            if (quote.userDetails!.isHidden == true) {
              cubit.unhideQuote();
            } else {
              cubit.hideQuote();
            }
          },
        ),
        DeleteIconButton(
          onTap: () {
            cubit.deleteQuote();
          },
        ),
        if (shareableLinkGenerator != null)
          ShareIconButton(
            onTap: () async {
              final url = await shareableLinkGenerator(quote);
              Share.share(url);
            },
          ),
        CustomMenuAnchor(
          menuChildren: [
            //TODO refine this icon to reflect a tag & the onTap method call.
            CustomMenuItemButton(
              label: l10n.addTagToQuoteMenuItemButtonLabel,
              trailingIcon: const Icon(Icons.local_offer),
              onTap: () {
                cubit.addPersonalTagsToQuote();
              },
            ),
            CustomMenuItemButton(
              label: l10n.addQuoteMenuItemButtonLabel,
              trailingIcon: const Icon(Icons.format_quote),
              onTap: () => cubit.addQuote(),
            ),
            CustomMenuItemButton(
              label: quote.isPrivate == true
                  ? l10n.makeQuotePublicMenuItemButtonLabel
                  : l10n.makeQuotePrivateMenuItemButtonLabel,
              trailingIcon: quote.isPrivate == true
                  ? const Icon(Icons.public)
                  : const Icon(Icons.public_off),
              onTap: () => cubit.makeQuotePublic(),
            )
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _Quote extends StatefulWidget {
  const _Quote({
    required this.quote,
    this.l10n,
    this.userRepository,
  });

  final Quote quote;
  final QuoteDetailsLocalizations? l10n;
  final UserRepository? userRepository;

  @override
  State<_Quote> createState() => __QuoteState();
}

class __QuoteState extends State<_Quote> {
  static const double _quoteIconWidth = 46.0;
  static const double chatBoxSeparatorHeight = 8.0;
  static const double _screenWidthFactor = 0.7;
  late final StreamSubscription _authChangesSubscription;
  String? _authenticedUsername;
  late final Quote _quote;
  late final QuoteDetailsLocalizations _l10n;
  late final ThemeData theme;

  @override
  void initState() {
    super.initState();
    _quote = widget.quote;
    _l10n = widget.l10n ?? QuoteDetailsLocalizations.of(context);
    _authChangesSubscription =
        widget.userRepository!.createUserSession().listen((user) {
      _authenticedUsername = user!.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final quoteTextStyle =
        (wallpaperTheme?.quoteTextStyle ?? defaultTheme?.quoteTextStyle);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: Spacing.expandedHeight,
          flexibleSpace: _buildQuoteContent(quoteTextStyle!),
        ),
        if (wallpaperTheme != null) ...[
          FutureBuilder(
            future: wallpaperTheme.themeData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: CenteredCircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const SliverToBoxAdapter(
                  child: ExceptionIndicator(
                      title: 'Failed to Load theme for dialogue list'),
                );
              } else if (snapshot.hasData) {
                return buildDialogueList(snapshot.data!);
              } else {
                return const SliverToBoxAdapter(
                  child: ExceptionIndicator(
                      title: 'No theme data is available for DialogueList'),
                );
              }
            },
          ),
        ],
        if (defaultTheme != null) ...[
          buildDialogueList(defaultTheme.materialThemeData),
        ],
      ],
    );
  }

  FlexibleSpaceBar _buildQuoteContent(
    TextStyle quoteTextStyle,
  ) {
    return FlexibleSpaceBar(
      background: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: OpeningQuoteSvgAsset(
              width: _quoteIconWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxLarge,
              ),
              child: Center(
                child: ShrinkableText(
                  _quote.body!,
                  style: quoteTextStyle.copyWith(
                    fontSize: FontSize.xxlarge,
                  ),
                ),
              ),
            ),
          ),
          const ClosingQuoteSvgAsset(
            width: _quoteIconWidth,
          ),
          const SizedBox(
            height: Spacing.medium,
          ),
          Text(
            _quote.author ?? '',
            style: const TextStyle(
              fontSize: FontSize.large,
            ),
          )
        ],
      ),
    );
  }

  SliverList buildDialogueList(ThemeData theme) {
    return SliverList.separated(
      itemCount: _quote.dialogueLines?.length ?? 0,
      itemBuilder: (context, index) {
        final dialogueLine = _quote.dialogueLines![index];
        //TODO refine this condition to get the actual user
        final bool isCurrentUser = dialogueLine.author == _authenticedUsername;
        return Align(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Spacing.xSmall,
              horizontal: Spacing.small,
            ),
            padding: const EdgeInsets.all(Spacing.medium),
            constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width * _screenWidthFactor),
            decoration: _buildBoxDecoration(
              theme: theme,
              isCurrentUser: isCurrentUser,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (dialogueLine.author != null && !isCurrentUser)
                  Text(
                    dialogueLine.author ?? _l10n.unknownAuthorPlaceholder,
                    style: TextStyle(
                      fontSize: FontSize.small,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                Text(
                  dialogueLine.body ?? _l10n.noContentAvailablePlaceholder,
                  style: TextStyle(
                    color: isCurrentUser
                        ? theme.colorScheme.onSecondaryContainer
                        : theme.colorScheme.onSurfaceVariant,
                    fontSize: FontSize.medium,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    dialogueLine.formattedTimestamp,
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      color: isCurrentUser
                          ? theme.colorScheme.onSecondaryFixedVariant
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          const SizedBox(height: chatBoxSeparatorHeight),
    );
  }

  BoxDecoration _buildBoxDecoration({
    required ThemeData theme,
    required bool isCurrentUser,
  }) {
    return BoxDecoration(
      color: isCurrentUser
          ? theme.colorScheme.secondaryContainer
          : theme.colorScheme.surfaceDim,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(Spacing.medium),
        topRight: const Radius.circular(Spacing.medium),
        bottomLeft:
            isCurrentUser ? const Radius.circular(Spacing.medium) : Radius.zero,
        bottomRight:
            isCurrentUser ? Radius.zero : const Radius.circular(Spacing.medium),
      ),
    );
  }
}

/*
---Don't use BlocBuilder to display a snackbar or dialog to navigate 
to another screen. Use a BlocListener instead.
---As a UX rule of thumb, use an 'error state' widget to show errors
that occured while retrieving information, and a snackbar or dialog to
display errors that occured when sending information.
*/
