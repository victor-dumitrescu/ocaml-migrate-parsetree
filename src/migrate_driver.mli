open Migrate_parsetree.Versions

(** {1 State a rewriter can access} *)

type config = {
  tool_name       : string;
  include_dirs    : string list;
  load_path       : string list;
  debug           : bool;
  for_package     : string option;
}

type cookies

val get_cookie
  : cookies
  -> string
  -> 'types ocaml_version -> 'types get_expression option

val set_cookie
  : cookies
  -> string
  -> 'types ocaml_version -> 'types get_expression
  -> unit

(** {1 Registering rewriters} *)

type 'types rewriter = config -> cookies -> string list -> 'types get_mapper

val register
  :  name:string -> ?args:(Arg.key * Arg.spec * Arg.doc) list
  -> 'types ocaml_version -> 'types rewriter
  -> unit

(** {1 Running registered rewriters} *)

val run_as_ast_mapper : string list -> Ast_mapper.mapper

val run_main : unit -> 'a