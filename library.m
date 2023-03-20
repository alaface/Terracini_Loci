// FanoX
// INPUT: a positive integer n
// OUTPUT: the n-th smooth toric Fano variety 
// from the corresponding database

FanoX := function(ID)
 block := ID div 250;
 num := (ID mod 250);
 L := GetLibraryRoot();
 file := L cat "/data/polytopes/smoothfano/block" cat IntegerToString( block );
 fh := Open( file, "r" );
 base := Gets( fh );
 while num gt 0 do
   line := Gets( fh );
   num -:= 1;
 end while;
 base := StringToInteger( base );
 line := StringToInteger( line );
 coeffs := IntegerToSequence( line, base );
 dim := coeffs[1];
 shift := coeffs[2];
 coeffs := [ coeffs[i] - shift : i in [3..#coeffs] ];
 vertices := [ [ coeffs[dim * i + j] : j in [1..dim] ] : 
 i in [0..#coeffs div dim - 1]];
 P := Polytope(vertices);
 F := SpanningFan(P);
 X := ToricVariety(Rationals(),F);
 return X;
end function;

// AX
// INPUT: a projective toric variety X
// OUTPUT: the ample body of X

AX := function(X)
 forms := IntersectionForms(X);
 pol := &meet[HalfspaceToPolyhedron(v,1) : v in forms];
 return CompactPart(pol);
end function;
