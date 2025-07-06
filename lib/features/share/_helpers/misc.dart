import '../../../_helpers/common/global.dart';
import '../../../_variables/constants.dart';

String getWindowTitle(String type, String itemTitle) {
  return itemTitle;
}

String getSharedItemId(String path) {
  try {
    return splitList(path, separator: '-').last;
  } catch (e) {
    return noValue;
  }
}

String getSharedSpaceId(String path) {
  try {
    return splitList(path, separator: '-')[1];
  } catch (e) {
    return noValue;
  }
}

bool isCustomLink(String path) => !path.contains('-');
