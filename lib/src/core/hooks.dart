// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useMountedEffect(void Function()? Function() effect,
    [List<Object?>? keys]) {
  final didMount = useState(false);
  final mounted = useIsMounted();

  useEffect(() {
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted()) didMount.value = true;
      },
    );
  }, []);

  useEffect(() {
    if (didMount.value) {
      return effect();
    }
  }, [...?keys, didMount.value]);
}

VoidCallback useSetState() {
  final state = useState(false);

  return () {
    state.value = !state.value;
  };
}

T useMemo<T>(T value) {
  return useMemoized<T>(() => value, []);
}

void useMounted(VoidCallback func) {
  useMountedEffect(() {
    func();
  }, []);
}

void useWillMount(VoidCallback func) {
  return useEffect(() {
    func();
  }, []);
}

void useDispose(VoidCallback func) {
  return useEffect(() {
    return func;
  }, []);
}
