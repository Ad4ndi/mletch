let env cmd =
  let ic = Unix.open_process_in cmd in
  let output = try input_line ic with End_of_file -> "Unknown" in
  close_in ic;
  output

let uptime () =
  let out = env "uptime" in
  try
    let up_idx = String.index out 'u' in
    let after_up = String.sub out (up_idx + 3) (String.length out - up_idx - 3) in
    let parts = String.split_on_char ',' after_up in
    String.trim (List.hd parts)
  with _ -> "Unknown"

let shell () =
  try Filename.basename (Sys.getenv "SHELL")
  with Not_found -> "Unknown"

let color_text hex text =
  Printf.sprintf "\027[38;2;%d;%d;%dm%s\027[0m"
    (int_of_string ("0x" ^ String.sub hex 0 2))
    (int_of_string ("0x" ^ String.sub hex 2 2))
    (int_of_string ("0x" ^ String.sub hex 4 2))
    text

let white text = "\027[97m" ^ text ^ "\027[0m"

