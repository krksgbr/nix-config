{ lib }:
{
  isDarwin = system: lib.strings.hasSuffix "darwin" system;
}
