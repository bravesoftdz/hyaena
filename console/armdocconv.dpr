
program armdocconv;

{$APPTYPE CONSOLE}
  
uses
  SysUtils,
  args,
  msoffice in 'msoffice.pas';

 procedure showhelp;
 begin
     writeln ('doc files converter from armscii-8 to unicode');
     writeln ('(c) copyright 2006 by Norayr Chilingaryan');
     writeln ('this utility converts armscii08 word documents into utf-8 ones');
     writeln ('Usage');
     writeln (' filename - full filename including path to convert');
     writeln ('example');
     writeln ('armdocconv c:\file.doc');
     writeln;
     writeln ('-o filename - input (old) file');
     writeln ('-n filename - output (new)file');
     writeln ('example');
     writeln ('armdocconv -o c:\oldfile.doc -n c:\newfile.doc');
     writeln;
     halt;
  end;

 procedure Convert (s1, s2 : string);
 var a : array [0..94] of String;
 u : array [0..94] of widestring;
 begin

  a[0] := #179; u[0] := #1377; // a
  a[1] := #178; u[1] := #1329; // A
  a[2] := #181; u[2] := #1378; // b
  a[3] := #180; u[3] := #1330; // B
  a[4] := #182; u[4] := #1331; // G
  a[5] := #183; u[5] := #1379; // g
  a[6] := #184; u[6] := #1332; // D
  a[7] := #185; u[7] := #1380; // d
  a[8] := #186; u[8] := #1333; // E
  a[9] := #187; u[9] := #1381; // e
  a[10] := #188; u[10] := #1334; // Z
  a[11] := #189; u[11] := #1382; // z
  a[12] := #190; u[12] := #1335; // E'
  a[13] := #191; u[13] := #1383; // e'
  a[14] := #192; u[14] := #1336; // Y'
  a[15] := #193; u[15] := #1384; // y'
  a[16] := #194; u[16] := #1337; // T'
  a[17] := #195; u[17] := #1385; // t'
  a[18] := #196; u[18] := #1338; // Zh
  a[19] := #197; u[19] := #1386; // zh
  a[20] := #198; u[20] := #1339; // I
  a[21] := #199; u[21] := #1387; // i
  a[22] := #200; u[22] := #1340; // L
  a[23] := #201; u[23] := #1388; // l
  a[24] := #202; u[24] := #1341; // Kh
  a[25] := #203; u[25] := #1389; // kh
  a[26] := #204; u[26] := #1342; // Ts
  a[27] := #205; u[27] := #1390; // ts
  a[28] := #206; u[28] := #1343; // K
  a[29] := #207; u[29] := #1391; // k
  a[30] := #208; u[30] := #1344; // H
  a[31] := #209; u[31] := #1392; // h
  a[32] := #210; u[32] := #1345; // Dz
  a[33] := #211; u[33] := #1393; // dz
  a[34] := #212; u[34] := #1346; // Gh
  a[35] := #213; u[35] := #1394; // gh
  a[36] := #214; u[36] := #1347; // Tch
  a[37] := #215; u[37] := #1395; // tch
  a[38] := #216; u[38] := #1348; // M
  a[39] := #217; u[39] := #1396; // m
  a[40] := #218; u[40] := #1349; // Y
  a[41] := #219; u[41] := #1397; // y
  a[42] := #220; u[42] := #1350; // N
  a[43] := #221; u[43] := #1398; // n
  a[44] := #222; u[44] := #1351; // Sh
  a[45] := #223; u[45] := #1399; // sh
  a[46] := #224; u[46] := #1352; // Vo
  a[47] := #225; u[47] := #1400; // vo
  a[48] := #226; u[48] := #1353; // Ch
  a[49] := #227; u[49] := #1401; // ch
  a[50] := #228; u[50] := #1354; // P
  a[51] := #229; u[51] := #1402; // p
  a[52] := #230; u[52] := #1355; // J
  a[53] := #231; u[53] := #1403; // j
  a[54] := #232; u[54] := #1356; // R
  a[55] := #233; u[55] := #1404; // r
  a[56] := #234; u[56] := #1357; // S
  a[57] := #235; u[57] := #1405; // s
  a[58] := #236; u[58] := #1358; // V
  a[59] := #237; u[59] := #1406; // v
  a[60] := #238; u[60] := #1359; // T
  a[61] := #239; u[61] := #1407; // t
  a[62] := #240; u[62] := #1360; // R'
  a[63] := #241; u[63] := #1408; // r'
  a[64] := #242; u[64] := #1361; // C
  a[65] := #243; u[65] := #1409; // c
  a[66] := #244; u[66] := #1362; // ta shtuka s yev
  a[67] := #245; u[67] := #1410; // -"-
  a[68] := #246; u[68] := #1363; // P'
  a[69] := #247; u[69] := #1411; // p'
  a[70] := #248; u[70] := #1364; // Q
  a[71] := #249; u[71] := #1412; // q
  a[72] := #250; u[72] := #1365; // O
  a[73] := #251; u[73] := #1413; // o
  a[74] := #252; u[74] := #1366; // F
  a[75] := #253; u[75] := #1414; // f
  a[76] := #162; u[76] := #1415; // yev
  a[77] := #168; u[77] := #1415; // yev
  a[78] := #169; u[78] := #0046; // .
  a[79] := #96;  u[79] := #1373;    // but
  a[80] := #170; u[80] := #1373;
  a[81] := #171; u[81] := #0044;       //,
  a[82] := #152; u[82] := #1375;     // `-
  a[83] := #173; u[83] := #1375;
  a[84] := #167 ; u[84] := {#34;} #0171{#$ab};    // <<      #8920
  a[85] := #175; u[85] := #1372;  // tipa tilda
  a[86] := #176; u[86] := #1371;  //shesht
  a[87] := #177; u[87] := #1374;  //paruyk
  a[88] := #58;  u[88] := #1417; // :
  a[89] := #166; u[89] := {#34;} #0187; // >>          #8918
  a[90] := #163; u[90] := #1417; // :
  a[91] := #164; u[91] := #41; // )
  a[92] := #165; u[92] := #40; // (
  a[93] := #172; u[93] := #45; // -
  a[94] := #173; u[94] := #1375;
  

  //for i := 0 to high(a) do begin
  if not msoffice.Word_CharsReplace(s1, s2, a,u,[wrfReplaceAll, wrfMatchCase, wrfMatchWildcards]) then
  writeln ('conversion failed')
  else
  writeln ('conversion successfully done!');

  //end;
  {
  if msoffice.Word_StringReplace(s1, s2, #65,#1350,[wrfReplaceAll]) then
  writeln ('ok') else writeln ('conversion failed');
  halt;
   }

 {Word_StringReplace('C:\Test.doc','Old String','New String',[wrfReplaceAll,wrfMatchCase]);

}

 end;

 procedure run;
 var s : string;
 begin
 if args.IsThereArgs = false then showhelp;
 if ParamCount = 1 then begin
 s := ParamStr(1);
 if copy (s, 2, 1 ) <> ':' then begin showhelp; halt; end;
 if (SysUtils.ExtractFileExt(s) = '.doc') or (SysUtils.ExtractFileExt(s) = '.docx')  then begin
     writeln ('seems to be ms word document');
     writeln ('checking for ms word presence');
      if not msoffice.MSWordIsInstalled then begin
            writeln ('ms word is not installed');
           halt;
        end
      else
       begin
       writeln ('installed');
       writeln;
       end;
 end;


 WriteLn ('Converting ' + s + ' from armscii-8 to Unicode (UTF-8)');
 WriteLn ('As new file name is not provided ( -n option ) file will be overwritten');
 Convert (s, '');
 WriteLn ('thanks for using');
 halt;
 end;
 if ParamCount <4 then showhelp;
 if ParamCount > 4 then showhelp;
 if copy (ParamValue('-o'), 2, 1 ) <> ':' then begin showhelp; halt  end;
 if copy (ParamValue('-n'), 2, 1 ) <> ':' then begin showhelp; halt  end;

 WriteLn ('Converting ' + ParamValue('-o') + ' from armscii-8 to Unicode (UTF-8)');
 Convert (args.ParamValue('-o'),args.ParamValue('-n'));
 WriteLn ('thanks for using');

 end;

begin

 run;

end.



