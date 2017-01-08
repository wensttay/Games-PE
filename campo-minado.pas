
///------------------------------------------------------///
///     Author: Wensttay de Sousa Alencar     ///
///------------------------------------------------------///
Program questao4;

Uses crt;

Const
	Linhas_Reais = 10;
	Colunas_Reais = 10;
	Numero_de_Bombas = 20;
	PosX = 15;
	PosY = 8;

Type
	matriz = array[1..Linhas_Reais,1..Colunas_Reais] of char;
	matrizInt = array[1..Linhas_Reais,1..Colunas_Reais] of integer;

Var
	iniciar: char;
	Estrutura: matriz;
	Bomba: matrizInt;
	CorX, CorY, X, Y:integer;
	Open, Pontuacao, Aux:integer;
	GameOver,continua,Vencedor: Boolean;
	Reiniciar:char;
	EspasoVazio:integer;

///------------------------///
/// SUBPROGRAMA PRO TITULO ///
///------------------------///
Procedure TITULO;
	Begin
		gotoxy(2,2); textcolor(12); write('//////////////////////////////////////////////////////////////////////////////');
		gotoxy(2,3); textcolor(12); write('|||||||||||||||||||||||||||||| '); textcolor(White); write('CAMPO MINADO'); textcolor(12); write(' ||||||||||||||||||||||||||||||||||');
		gotoxy(2,4); textcolor(12); write('//////////////////////////////////////////////////////////////////////////////');
	End;

///-------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME O PRIMEIRO MENU DO JOGO ///
///-------------------------------------------------///
Procedure  PrimeiroMenu(var iniciar:char);
	Begin
		Begin
			Repeat
				clrscr;
				TITULO;
				gotoxy(PosX,PosY); textcolor(15); write('        PARA INICIAR O JOGO DIGITE '); textcolor(12);  write('1'); textcolor(15); write(': ');
				gotoxy(PosX,PosY+3); textcolor(15); write('        PARA LER O TUTORIAL DIGITE '); textcolor(12); write('2'); textcolor(15); write(': ');
				gotoxy(PosX+39,PosY+2); readln(iniciar);

				if iniciar = '2' then
					Begin
						clrscr;
						TITULO;
						gotoxy(5,6); textcolor(12); write('                              TUTORIAL');
						gotoxy(5,8); textcolor(15); write('Nesse game de Campo Minado o jogador deve tentar "andar" em todas as areas ');
						gotoxy(5,9); textcolor(15); write('seguras sem "pisar" nas minas escondidas no mapa.');
						gotoxy(5,11); textcolor(12); write('Como jogar?');
						gotoxy(5,13); textcolor(15); write('Escolha uma coordenada de uma linha e de uma coluna e arisque sua vida!');
						gotoxy(5,14); write('Quanto mais casas voce abrir sem "pisar" na mina, maior sera sua pontuacao.');
						gotoxy(5,15); write('Quanto MAIOR for o numero de minas ao redor da casa escolhida, maior ');
						gotoxy(5,16); write('ser  o BONUS de pontos!');
						gotoxy(5,18); textcolor(12); write('Quando Termina o Jogo?');
						gotoxy(5,20); textcolor(15); write('Quando o jogador abrir uma coordenada com uma mina ou quando todas');
						gotoxy(5,21); write('as areas seguras forem abertas.');
						gotoxy(5,23); textcolor(12); write('Precione qualquer tecla para retornar ao menu anterior: ');
						readln; KeyPressed;
					End;

				if (iniciar <> '1') and (iniciar <> '2') then
					Begin
						clrscr;
						PrimeiroMenu(iniciar);
					End;
			Until iniciar = '1';
		End;
	End;

///----------------------------------------------------///
/// SUBPROGRAMA QUE RESETA AS MATRIZES DO CAMPO MINADO ///
///----------------------------------------------------///
Procedure ResetMatriz(Linhas_Reais,Colunas_Reais:integer; var Estrutura:matriz; var Bomba:matrizInt);
Var
	L,C: Integer;

	Begin
		for L:= 1 to Linhas_Reais do
			for C:= 1 to Colunas_Reais do
				Begin
					Estrutura[L][C] := chr(254);
					Bomba[L][C] := 0;
				End;
	End;

///------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME O CAMPO DE MINAS ///
///------------------------------------------///
Procedure TABELA (Linhas_Reais,Colunas_Reais:integer; var Estrutura:matriz);
Var
	Pos,L,C,Alfa:integer;

	Begin
		Pos := 7;
		gotoxy(10,Pos-1);

		for L:= 1 to Colunas_Reais do
			Begin
				textbackground(Black);
				textcolor(12);
				write(' ',L);
			End;
		writeln;

		for L:= 1 to Linhas_Reais do
			Begin
				gotoxy(8,Pos);

				if L < 10 then
					Begin
						textbackground(Black);
						textcolor(White);
						write(' ',L);
					End
				else
					Begin
						textbackground(Black);
						textcolor(White);
						write(L);
					End;

				for C:= 1 to Colunas_Reais do
					Begin
						if Estrutura[L][C] = chr(254) then       /// QUANDO AINDA N TIVER ESCOLHIDO ///
							Begin
								textbackground(black);
								textcolor(5);
								write(' ',Estrutura[L][C]);
							End
						else if Estrutura[L][C] = chr(169) then   /// QUANDO FOR BOMBA ///
							Begin
								textbackground(black);
								textcolor(12);
								write(' ',Estrutura[L][C]);
							End
						else
							Begin
								textbackground(black);  /// QUANDO FOR NUMERO ///
								write(' ');
								textbackground(white);
								textcolor(Black);
								write(Estrutura[L][C]);
							End;
					End;

				textbackground(0);
				write(' ');
				textbackground(Black);
				textcolor(white);
				write(L,' ');
				writeln;
				Pos := Pos + 1;
			End;

		gotoxy(10,Pos);

		for L:= 1 to Colunas_Reais do
			if L < 11 then
				Begin
					textbackground(Black);
					textcolor(12);
					write(' ',L);
				End
			Else
				Begin
					textbackground(Black);
					textcolor(12);
					write(L:2);
				End;

		textcolor(white);
		textbackground(black);
	End;

///---------------------------------------------///
/// SUBPROGRAMA QUE SORTEIA OS LOCAIS DAS MINAS ///
///---------------------------------------------///
Procedure Random_Bombas (var Bomba:matrizInt);    /// Sorteando Bombas ///
Var
   X,Y,cont: integer;

	Begin
		X := 0;
		Y := 0;
		cont := 0;

		repeat
			randomize;
			X := random(Linhas_Reais)+1;
			Y := random(Colunas_Reais)+1;

			if Bomba[X][Y] = 0 then
				Begin
					Bomba[X][Y] := 1;
					cont := cont +1;
				End;

		Until cont = Numero_de_Bombas;
	End;

///----------------------------------------------///
/// SUBPROGRAMA QUE MOSTRA O QUADRADO DAS LINHAS ///
///----------------------------------------------///
Procedure ShowEstruturaLinhas (CorX,CorY:integer);
	Begin
		gotoxy(CorX+2,CorY); textcolor(12); write('Linha:'); textcolor(white);
		gotoxy(CorX,CorY+1); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(CorX,CorY+2); write(chr(186)); write('          ',chr(186));
		gotoxy(CorX,CorY+3); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///-----------------------------------------------///
/// SUBPROGRAMA QUE MOSTRA O QUADRADO DAS COLUNAS ///
///-----------------------------------------------///
Procedure ShowEstruturaColunas (CorX,CorY:integer);
	Begin
		gotoxy(CorX+2,CorY+5); textcolor(12); write('Coluna:'); textcolor(white);
		gotoxy(CorX,CorY+6); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(CorX,CorY+7); write(chr(186)); write('          ',chr(186));
		gotoxy(CorX,CorY+8); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///----------------------------------------------///
/// SUBPROGRAMA QUE MOSTRA O PLACAR DA PONTUACAO ///
///----------------------------------------------///
Procedure ShowEstruturaPontos (CorX,CorY:integer; Pontuacao:integer);
	Begin
		gotoxy(CorX+17,CorY+5); textcolor(12); write('Pontuacao:'); textcolor(white);
		gotoxy(CorX+16,CorY+6); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(CorX+16,CorY+7); write(chr(186)); gotoxy(CorX+21,CorY+7); write(Pontuacao); gotoxy(CorX+27,CorY+7); write(chr(186));
		gotoxy(CorX+16,CorY+8); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///---------------------------------------------------------------///
/// SUBPROGRAMA QUE DEFINE A SOMA DE APROXIMACAO AA MINAS DO JOGO ///
///---------------------------------------------------------------///
Procedure SomaMina (var Bomba:matrizInt; var Estrutura:matriz; var GameOver:Boolean; var Aux:integer);
	Begin
		if Bomba[X][Y] = 1 then
			Begin
				Estrutura[X][Y] := chr(169);
				GameOver := True;
			End
		Else if (X = 1) and (Y = 1) then
			Aux := (Bomba[X+1][Y] + Bomba[X+1][Y+1] + Bomba[X][Y+1])
		Else if (X = 1) and (Y = Linhas_Reais) then
			Aux := (Bomba[X][Y-1] + Bomba[X+1][Y-1] + Bomba[X+1][Y])
		Else if (X = Colunas_Reais) and (Y = Linhas_Reais) then
			Aux := (Bomba[X-1][Y] + Bomba[X-1][Y-1] + Bomba[X][Y-1])
		Else if (X = Colunas_Reais) and (Y = 1) then
			Aux := (Bomba[X-1][Y] + Bomba[X-1][Y+1] + Bomba[X][Y+1])
		Else if (Y = 1) then
			Aux := (Bomba[X-1][Y] + Bomba[X-1][Y+1] + Bomba[X][Y+1] + Bomba[X+1][Y+1] + Bomba[X+1][Y])
		Else if (Y = Linhas_Reais) then
			Aux := (Bomba[X-1][Y] + Bomba[X-1][Y-1] + Bomba[X][Y-1] + Bomba[X+1][Y-1] + Bomba[X+1][Y])
		Else if (X = 1) then
			Aux := (Bomba[X][Y-1] + Bomba[X+1][Y-1] + Bomba[X+1][Y] + Bomba[X+1][Y+1] + Bomba[X][Y+1])
		Else if (X = Colunas_Reais) then
			Aux := (Bomba[X][Y-1] + Bomba[X-1][Y-1] + Bomba[X-1][Y] + Bomba[X-1][Y+1] + Bomba[X][Y+1])
		Else
			Aux := (Bomba[X-1][Y] + Bomba[X-1][Y-1] + Bomba[X][Y-1] + Bomba[X+1][Y-1] + Bomba[X+1][Y] + Bomba[X+1][Y+1] + Bomba[X][Y+1] + Bomba[X-1][Y+1]);
	End;

///------------------------------------------------------------------------///
/// SUBPROGRAMA QUE TRANSFORMA A AUX INTEIRA EM EM CHAR PARA A "ESTRUTURA" ///
///------------------------------------------------------------------------///
Procedure Transform (var Aux:integer; var Estrutura:matriz);
	Begin
		Case Aux of
			0 : Estrutura[X][Y] := '0';
			1 : Estrutura[X][Y] := '1';
			2 : Estrutura[X][Y] := '2';
			3 : Estrutura[X][Y] := '3';
			4 : Estrutura[X][Y] := '4';
			5 : Estrutura[X][Y] := '5';
			6 : Estrutura[X][Y] := '6';
			7 : Estrutura[X][Y] := '7';
			8 : Estrutura[X][Y] := '8';
		End;
	End;

///--------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA SE QUER REINICIAR ///
///--------------------------------------------///
Procedure Reini(var Reiniciar:char);
Var
	condi:char;

	Begin
		condi := 'o';
        gotoxy(10,20);write('Deseja jogar Novamente ?(s/n) ');
        readln(condi);
        case condi of
			's' : Reiniciar := 's';
			'n' : Reiniciar := 'n';
        else
            Reini(Reiniciar);
        End;
	End;

///------------------------------------------///
/// SUBPROGRAMA QUE IMPRIMI O CAMPO REVELADO ///
///------------------------------------------///
Procedure CampoRevelado (Linhas_Reais,Colunas_Reais:integer; var Estrutura:matriz);
Var
	L, C:integer;

	Begin
		for L:= 1 to Linhas_Reais do
            for C:= 1 to Colunas_Reais do
				Estrutura[L][C] := chr(254);

        for L:= 1 to Linhas_Reais do
			for C:= 1 to Colunas_Reais do
				if Bomba[L][C] = 1 then
					Estrutura[L][C] := chr(169)
				Else
					Estrutura[L][C] := ' ';
	End;

///--------------------///
/// PROGRAMA PRINCIPAL ///
///--------------------///
Begin
	Repeat
		PrimeiroMenu(iniciar);
		clrscr;
		EspasoVazio := (Linhas_Reais*Colunas_Reais) - Numero_de_Bombas;
		X := 0;
		Y := 0;
		ResetMatriz(Linhas_Reais,Colunas_Reais,Estrutura,Bomba);
		Random_Bombas(Bomba);
		TITULO;
		TABELA(Linhas_Reais,Colunas_Reais,Estrutura);
		CorX:= 40;
		CorY:= 6;
		ShowEstruturaLinhas (CorX,CorY);
		ShowEstruturaColunas (CorX,CorY);
		Open := 0;
		Pontuacao :=0;

///---------------------///
/// INICIA TELA DE JOGO ///
///---------------------///
		Repeat
			TABELA(Linhas_Reais,Colunas_Reais,Estrutura);
			ShowEstruturaPontos (CorX,CorY,Pontuacao);
			gotoxy(CorX+5,CorY+2); write('    ');
			gotoxy(CorX+5,CorY+7); write('    ');
			gotoxy(CorX+5,CorY+2); read(X);
			gotoxy(CorX+5,CorY+7); read(Y);

			Vencedor := False;
			Continua := False;
			GameOver := False;

			If Estrutura[X][Y] = chr(254) then
				continua := True;

			if (continua) then
				Begin
					SomaMina (Bomba,Estrutura,GameOver,Aux);
					Transform (Aux,Estrutura);
					Pontuacao := Pontuacao + 5 + Aux;
					Open := Open +1;
				End;

		Until (GameOver) or (Open =  EspasoVazio);

		if Open =  EspasoVazio then
			Begin
				gotoxy(45,17); write('PARABENS ! VOCE GANHOU');
			End
		Else
			Begin
				gotoxy(45,17); textcolor(12); write(' GAME OVER !!')
			End;

		CampoRevelado (Linhas_Reais,Colunas_Reais,Estrutura);
		TABELA(Linhas_Reais,Colunas_Reais,Estrutura);
		Reini(Reiniciar);

	Until  (Reiniciar = 'n');

End.