let test_configure_options =
  let test name version option ~expected =
    ( name,
      `Quick,
      fun () ->
        let got =
          Ocaml_version.Configure_options.to_configure_flag version option
        in
        Alcotest.check Alcotest.string __LOC__ expected got )
  in
  let v3_12 = Ocaml_version.of_string_exn "3.12.1" in
  [
    test "FP on last 4.07" Ocaml_version.Releases.v4_07 `Frame_pointer
      ~expected:"-with-frame-pointer";
    test "FP on first 4.08" Ocaml_version.Releases.v4_08_0 `Frame_pointer
      ~expected:"--enable-frame-pointers";
    test "FP on 3.12" v3_12 `Frame_pointer ~expected:"-with-frame-pointer";
  ]

let () =
  Alcotest.run "ocaml-version" [ ("Configure_options", test_configure_options) ]
