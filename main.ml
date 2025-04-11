open Utils
open Args
open Ascii

let print_help () =
  print_endline "Usage: mletch [options]";
  print_endline "Options:";
  print_endline "  -h            Show help";
  print_endline "  -c <hex>      Set color for labels";
  print_endline "  -p <hex>      Set color for logo";
  print_endline "  -u            Uppercase output";
  print_endline "  -l            Lowercase output";
  print_endline "  -s <sep>      Replace ':' with custom separator";
  print_endline "  -b <char>     Change underline character";
  print_endline "  -i <file>     Load ASCII art and insert info next to lines"

let () =
  let (color, logo_color, sep, bar, to_upper, to_lower, ascii_file) = parse_args () in

  let apply_case s =
    if to_upper then String.uppercase_ascii s
    else if to_lower then String.lowercase_ascii s
    else s
  in

  let label lbl = color_text color (apply_case lbl) in
  let value v = white (apply_case v) in
  let logo lbl = color_text logo_color (apply_case lbl) in

  let user = Unix.getlogin () in
  let host = Unix.gethostname () in
  let line0 = label user ^ label "@" ^ label host in
  let underline = String.make (String.length (user ^ "@" ^ host)) (String.get bar 0) |> white in

  let info_lines = [
    line0;
    underline;
    Printf.sprintf "%s%s%s" (label "System") sep (value (env "uname -s"));
    Printf.sprintf "%s%s%s" (label "Kernel") sep (value (env "uname -r"));
    Printf.sprintf "%s%s%s" (label "Uptime") sep (value (uptime ()));
    Printf.sprintf "%s%s%s" (label "Termsh") sep (value (shell ()))
  ] in

  if ascii_file <> "" then output_info_with_ascii ascii_file info_lines logo
  else List.iter print_endline info_lines

