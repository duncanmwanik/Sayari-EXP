import '../../../_state/_providers.dart';

void goToView(String type) {
  if (type != state.views.view) {
    state.views.setView(type);
    state.input.clear();
    state.data.clear();
    state.doc.reset();
  }
}
