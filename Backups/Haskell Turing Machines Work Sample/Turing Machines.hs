--Taylor Lucero
--tlucero@syr.edu

import Turing

hwhhTM ::Prog
hwhhTM =
       [
        (("start", 'h'), ( 'h', Rght, "sawH")),
        (("start", 'w') ,( 'w', Rght, "start")),

        (("sawH", 'h'), ('h', Rght, "sawH")),
        (("sawH", 'w'), ('w', Rght, "sawHW")),

        (("sawHW", 'h'), ('h', Rght, "sawHWH")),
        (("sawHW", 'w'), ('w', Rght, "start")),
        (("sawHW", ' '), (' ', Lft, "goback")),

        (("sawHWH", 'h'), ('X', Rght, "sawH")),
        (("sawHWH", 'w'), ('w', Rght, "sawHW")),
        (("sawHWH", ' '), (' ', Lft, "goback")),

        (("findEnd", 'h'), ('h', Rght, "findEnd")),
        (("findEnd", 'w'), ('w', Rght, "findEnd")),
        (("findEnd", '1'), ('1', Rght, "findEnd")),
        (("findEnd", ' '), ('1', Lft, "goback")),
        
        (("goback", '1'), ('1',Lft, "goback")),
        (("goback", 'h'), ('h', Lft, "goback")),
        (("goback", 'w'), ('w', Lft, "goback")),
        (("goback", 'X'), ('h', Rght, "findEnd"))
        ]

        
reorder :: Prog
reorder =
        [
        (("start", 'e'), ('X', Rght, "sawE")),
        (("start", 'd'), ('d', Rght, "start")),
        

        (("sawE", 'e'), ('e',Rght, "sawE")),
        (("sawE", 'd'), ('e',Lft, "reverse")),
        (("sawE" , ' '), (' ', Lft, "findEnd")),

        (("reverse", 'e'),('e', Lft, "reverse")),
        (("reverse", 'X'),('d', Rght, "start")),

        (("findEnd", 'X'), ('d', Lft, "findEnd")),
        (("findEnd", 'e'), ('e',Lft, "findEnd")),
        (("findEnd" ,'d'), ('d', Lft, "done"))
        ]

twoTM :: Prog
twoTM =
      [
       (("start",'1'), ('X', Rght, "start")),
       (("start",'2'), ('2', Rght, "start")),
       (("start",'3'), ('3', Rght, "start")),
       (("start", ' '),(' ', Lft, "rotation1")),

       (("rotation1",'2'),('2', Lft, "find3")),
       (("rotation1",'3'),('3', Lft, "find2")),
       (("rotation1", ' '), (' ', Lft, "done")),
       (("rotation1", 'M'), ('M', Lft, "rotation1")),
       (("rotation1", 'F'), ('F', Lft, "rotation1")),
       (("rotation1", 'X'), ('X',Lft, "rotation1")),
       

       (("find3",'X'),('X',Lft, "find3")),
       (("find3",'3'),('F',Rght, "find2")),
       (("find3", '2'),('2',Lft, "find3")),
       (("find3", ' '),(' ',Rght,"end")),
       (("find3",'F'),('F',Lft,"find3")),
       (("find3", 'M'),('M', Lft, "rotation1")),

       (("find2", 'X'), ('X',Rght, "find2")),
       (("find2", '2'), ('M', Lft, "find3")),
       (("find2", 'F'), ('F', Rght, "find2")),
       (("find2", '3'), ('3', Rght, "find2")),
       (("find2", ' '), (' ', Lft, "end")),
       (("find2", 'M'), ('M', Rght, "find2")),

       (("end", 'X'),(' ', Rght, "end")),
       (("end", '2'),('M', Rght, "end")),
       (("end", '3'),('F', Rght, "end")),
       (("end", 'M'),(' ', Rght, "end")),
       (("end", 'F'),(' ', Rght, "end")),
       (("end", ' '),(' ', Lft, "rotation1"))

       
       
       ]
      