module: io-internals
synopsis:  Console determination
author: Gafrewig
copyright: (c) 2014 Dylan Hackers


define constant <console-colour-options> = one-of(#"base", #"plain", #"colour");


define abstract class <console-stream>(<wrapper-stream>)
end;

define class <non-console-output-stream>(<console-stream>)
end;

define class <console-output-stream>(<console-stream>)
end;

define method print-message(obj :: <console-styling>, str :: <console-stream>) => ()
end;

define method print-message(style :: <console-styling>, stream :: <console-output-stream>) => ()
  write(stream.inner-stream, as(<string>, style));
end;

define macro with-console-styling
  { with-console-styling ( ?style:name ) ?:body end }
    =>
  {
  format-out("%S", ?style);
  ?body;
  format-out("%S", *reset-console-styling*);
  }
end macro;
