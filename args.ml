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
  print_endline "  -i <file>     Load ASCII art"

let parse_args () =
  let color = ref "ffffff" in
  let logo_color = ref "ffffff" in
  let sep = ref ": " in
  let bar = ref "-" in
  let to_upper = ref false in
  let to_lower = ref false in
  let ascii_file = ref "" in

  let rec parse_args = function
    | [] -> ()
    | "-h" :: _ -> print_help (); exit 0
    | "-c" :: c :: tl -> color := c; parse_args tl
    | "-p" :: p :: tl -> logo_color := p; parse_args tl
    | "-u" :: tl -> to_upper := true; parse_args tl
    | "-l" :: tl -> to_lower := true; parse_args tl
    | "-s" :: s :: tl -> sep := s; parse_args tl
    | "-b" :: b :: tl -> bar := b; parse_args tl
    | "-i" :: f :: tl -> ascii_file := f; parse_args tl
    | _ :: tl -> parse_args tl
  in

  parse_args (List.tl (Array.to_list Sys.argv));
  (!color, !logo_color, !sep, !bar, !to_upper, !to_lower, !ascii_file)
