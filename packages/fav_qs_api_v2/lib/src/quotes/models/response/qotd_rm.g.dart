// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qotd_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QotdRM _$QotdRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'QotdRM',
      json,
      ($checkedConvert) {
        final val = QotdRM(
          date: $checkedConvert('qotd_date', (v) => v as String),
          quote: $checkedConvert(
              'quote', (v) => QuoteRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'date': 'qotd_date'},
    );
