open Core.Std
open Nocrypto


let gen_phrase wordfile length separator =
    let wordlist = In_channel.read_lines wordfile in
    let upper    = List.length wordlist in
    let passphrase = List.init ~f:(fun _ ->
        let ele = Rng.Int.gen_r 0 upper in
        List.nth_exn wordlist ele
        ) length
    in
    print_endline (String.concat ~sep:separator passphrase)

let command =
    Command.basic
        ~summary:"Generate strong passphrases"
        Command.Spec.(
            empty
            +> flag "-f" (optional_with_default "/usr/share/dict/words" file)
                ~doc:"filename Specify wordlist file"
            +> flag "-d" no_arg ~doc:" Use dash separation"
            +> anon (maybe_with_default 5 ("Phrase length" %: int))
        )
        (fun file use_dash phrase_len () ->
          match use_dash with
            | true -> gen_phrase file phrase_len "-"
            | false -> gen_phrase file phrase_len " "

        )

let () =
    Nocrypto_entropy_unix.initialize ();
    Command.run command
