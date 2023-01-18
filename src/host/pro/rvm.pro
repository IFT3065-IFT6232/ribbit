rvm_code(");'u?>vD?>vRD?>vRA?>vRA?>vR:?>vR=!(:lkm!':lkv6y"). % RVM code that prints HELLO!

print_string(S) :-
  atom_codes(A, S),
  print(A).
  
main :-
  rvm_code(C),
  print_string("RVM code:"),
  print_string("\n"),
  print_string(C),
  print_string("\n").

:- initialization((main, halt)). % start program
