abstract class Convert {
  static bool boolFromInt(int value) => value == 1;
  static int boolToInt(bool value) => value ? 1 : 0;
}
