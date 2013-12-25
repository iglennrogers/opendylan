module: io-internals
synopsis: Ansi codes for a terminal stream
author: Gafrewig
copyright: (c) 2013-4 Dylan Hackers

define constant $esc = as( <character>, 27 );

define constant *reset-attr* = format-to-string( "%S[0m", $esc );

define constant *bold-on* = format-to-string( "%S[1m", $esc );
define constant *bold-off* = format-to-string( "%S[22m", $esc );

define constant *underline-on* = format-to-string( "%S[4m", $esc );
define constant *underline-off* = format-to-string( "%S[24m", $esc );

define constant *inverse-on* = format-to-string( "%S[7m", $esc );
define constant *inverse-off* = format-to-string( "%S[27m", $esc );

define constant *fg-black* = format-to-string( "%S[0;30m", $esc );
define constant *fg-red* = format-to-string( "%S[0;31m", $esc );
define constant *fg-green* = format-to-string( "%S[0;32m", $esc );
define constant *fg-yellow* = format-to-string( "%S[0;33m", $esc );
define constant *fg-blue* = format-to-string( "%S[0;34m", $esc );
define constant *fg-magenta* = format-to-string( "%S[0;35m", $esc );
define constant *fg-cyan* = format-to-string( "%S[0;36m", $esc );
define constant *fg-white* = format-to-string( "%S[0;37m", $esc );

define constant *bg-black* = format-to-string( "%S[0;40m", $esc );
define constant *bg-red* = format-to-string( "%S[0;41m", $esc );
define constant *bg-green* = format-to-string( "%S[0;42m", $esc );
define constant *bg-yellow* = format-to-string( "%S[0;43m", $esc );
define constant *bg-blue* = format-to-string( "%S[0;44m", $esc );
define constant *bg-magenta* = format-to-string( "%S[0;45m", $esc );
define constant *bg-cyan* = format-to-string( "%S[0;46m", $esc );
define constant *bg-white* = format-to-string( "%S[0;47m", $esc );

// colours & styles

define constant <ansi-colour> = one-of(#f, #"black", #"red", #"green", #"yellow", #"blue", #"magenta", #"cyan", #"white");

define constant <ansi-style> = one-of(#f, #"bold", #"underline", #"inverse", #"bold-off", #"underline-off", #"inverse-off");


define method ansi-string (col :: <ansi-colour>, type == #"fg") => (code :: <string>)
  select (col) 
    #"black" => *fg-black*;
    #"red" => *fg-red*;
    #"green" => *fg-green*;
    #"yellow" => *fg-yellow*;
    #"blue" => *fg-blue*;
    #"magenta" => *fg-magenta*;
    #"cyan" => *fg-cyan*;
    #"white" => *fg-white*;
    otherwise => "";
  end;
end;

define method ansi-string (col :: <ansi-colour>, type == #"bg") => (code :: <string>)
  select (col) 
    #"black" => *bg-black*;
    #"red" => *bg-red*;
    #"green" => *bg-green*;
    #"yellow" => *bg-yellow*;
    #"blue" => *bg-blue*;
    #"magenta" => *bg-magenta*;
    #"cyan" => *bg-cyan*;
    #"white" => *bg-white*;
    otherwise => "";
  end;
end;

define method ansi-string (opt :: <ansi-style>, type) => (code :: <string>)
  select (opt) 
    #"bold" => *bold-on*;
    #"underline" => *underline-on*;
    #"inverse" => *inverse-on*;
    #"bold-off" => *bold-off*;
    #"underline-off" => *underline-off*;
    #"inverse-off" => *inverse-off*;
    otherwise => "";
  end;
end;

define class <console-styling>(<object>)
  constant slot foreground :: <ansi-colour>, init-keyword: fg:, init-value: #f;
  constant slot background :: <ansi-colour>, init-keyword: bg:, init-value: #f;
  constant slot style :: <ansi-style>, init-keyword: style:, init-value: #f;
end;

define constant *reset-console-styling* = make(<console-styling>);

define method as(cls == <string>, styling :: <console-styling>) => (res :: <string>)
  concatenate(*reset-attr*, ansi-string(styling.background, #"bg"), ansi-string(styling.foreground, #"fg"), 
              ansi-string(styling.style, #"style"));
end;
