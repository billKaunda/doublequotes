import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';

import '../activity_list.dart';
import 'activity_list_bloc.dart';

class ActivityPagedListView extends StatelessWidget {
  const ActivityPagedListView({
    required this.pagingController,
    this.onActivityLongPressed,
    super.key,
  });

  final PagingController<int, Activity> pagingController;
  final ActivityLongPressed? onActivityLongPressed;

  @override
  Widget build(BuildContext context) {
    final wallpaperTheme = WallpaperDoubleQuotesTheme.maybeOf(context);
    final defaultTheme = DefaultDoubleQuotesTheme.maybeOf(context);
    final screenMargin =
        (wallpaperTheme?.screenMargin ?? defaultTheme?.screenMargin) ??
            Spacing.mediumLarge;
    final gridSpacing =
        (wallpaperTheme?.gridSpacing ?? defaultTheme?.gridSpacing) ??
            Spacing.mediumLarge;
    final l10n = ActivityListLocalizations.of(context);
    final bloc = context.read<ActivityListBloc>();
    final onActivityLongPressed = this.onActivityLongPressed;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenMargin,
      ),
      child: PagedListView.separated(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Activity>(
          itemBuilder: (context, activity, index) {
            return ActivityCard(
              ownerType: activity.ownerType ?? l10n.activityOwnerTypeMissing,
              ownerValue: activity.ownerValue ?? l10n.activityOwnerNotFound,
              action: activity.action ?? l10n.activityActionNotFound,
              trackableType:
                  activity.trackableType ?? l10n.activityTrackableTypeMissing,
              trackableValue:
                  activity.trackableValue ?? l10n.trackableValueNotFound,
              message: activity.message ?? l10n.activityMessageBodyNotFound,
              onLongPress: onActivityLongPressed != null
                  ? () async {
                      final updatedActivity =
                          await onActivityLongPressed(activity.activityId);

                      if (updatedActivity != null) {
                        CustomAlertDialog(
                          title: l10n.customAlertDialogTitle,
                          content: l10n.customAlertDialogContent(
                            updatedActivity.trackableType!,
                            updatedActivity.action!,
                            updatedActivity.ownerValue!,
                          ),
                          actions: [
                            //Cancel
                            CustomTextButton(
                              label: l10n.cancelButtonLabel,
                              onPressed: () => Navigator.pop(
                                context,
                                l10n.cancelButtonLabel,
                              ),
                            ),
                            //Delete
                            CustomTextButton(
                              label: l10n.deleteButtonLabel,
                              onPressed: () {
                                Navigator.pop(context);
                                bloc.add(
                                  ActivityListItemDeleteRequest(
                                    updatedActivity.activityId,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    }
                  : null,
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return ExceptionIndicator(
              title: l10n.firstPageFetchErrorMessageTitle,
              message: l10n.firstPageFetchErrorMessageBody,
              onTryAgain: () => bloc.add(
                const ActivityListFailedFetchRetried(),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: gridSpacing,
        ),
      ),
    );
  }
}
