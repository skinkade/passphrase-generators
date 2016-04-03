let read_lines file =
  let infile = open_in file in
  let getline () =
    try Some (input_line infile) with End_of_file -> None in
  let rec loop lines = match getline () with
    | Some line -> loop (line :: lines)
    | None -> close_in infile; List.rev lines in
  loop []

let gen_phrase wordfile length dashes =
    let separator = match dashes with
        | true -> "-"
        | false -> " " in
    let wordlist = read_lines wordfile in
    let upper = List.length wordlist in
    let rand_ele () =
        List.nth wordlist (Random.int upper) in
    let rec loop dec = match dec with
        | 1 -> print_endline (rand_ele ())
        | _ -> print_string (rand_ele () ^ separator); loop (dec - 1) in
    loop length

(*
    OCaml's Random library is statistically uniform
    `self_init` draws a 96-bit seed from the system CSPRNG
*)
let () =
    Random.self_init();

    let wordfile = ref "/usr/share/dict/words" in
    let length = ref 5 in
    let dashes = ref false in

    let argDescr = [
        "-file", Arg.String (fun x -> wordfile := x), "<file> specify wordlist file";
        "-length", Arg.Int (fun x -> length := x), "<length> length of passphrase";
        "-dashes", Arg.Set dashes, " separate words with dashes"
    ] in
    Arg.parse (Arg.align argDescr) (fun x ->
        print_endline ("Unrecognized option: " ^ x)) "generate strong passphrases";

    gen_phrase !wordfile !length !dashes
