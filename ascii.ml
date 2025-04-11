let output_ascii ascii_path info_lines logo =
  try
    let ic = open_in ascii_path in
    let lines = ref [] in
    (try while true do lines := input_line ic :: !lines done with End_of_file -> ());
    close_in ic;
    let ascii = List.rev !lines in
    let max_len = List.fold_left (fun acc line -> max acc (String.length line)) 0 ascii in

    let rec merge a b =
      match a, b with
      | [], [] -> ()
      | a1 :: at, b1 :: bt ->
          let colored_a1 = logo a1 in
          Printf.printf "%-*s %s\n" max_len colored_a1 b1;
          merge at bt
      | a1 :: at, [] ->
          let colored_a1 = logo a1 in
          Printf.printf "%-*s\n" max_len colored_a1;
          merge at []
      | [], b1 :: bt ->
          Printf.printf "%-*s %s\n" max_len "" b1;
          merge [] bt
    in
    merge ascii info_lines
  with _ ->
    List.iter print_endline info_lines
