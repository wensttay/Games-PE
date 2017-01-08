
///------------------------------------------------------///
///     Author: Wensttay de Sousa Alencar     ///
///------------------------------------------------------///
Program questao5;

Uses crt;

Const
	Linhas = 10;
	Colunas = 10;
	Limite_de_Linhas = 15;
	Limite_de_Colunas = 15;
	Minimo_de_Linhas = 1;
	Minimo_de_Colunas = 1;
	Numero_de_Barcos = 20;
	Numero_de_Tiros = 20;
	PosX = 15;
	PosY = 8;

Type
	matriz = array [1..Limite_de_Linhas, 1..Limite_de_Colunas] of char;
    matrizInt = array [1..Limite_de_Linhas, 1..Limite_de_Colunas] of integer;

Var
	iniciar,resposta,condicao,ultimate,reini,Perguntaultimate,SemiReinicio:char;
	Linhas_Reais, Colunas_Reais:integer;
	Limite_de_linhas_Reais, Limite_de_Colunas_Reais:integer;
	Numero_de_Barcos_Reais, Numero_de_Tiros_Reais:integer;
	Estrutura: matriz;
	navios:matrizInt;
	X,Y,cont:integer;
	Letra:char;
	Pontuacao, Acertos_Seguidos, Pacumulada, Numero_de_Acertos, Maior_Sequencia_de_Acertos:integer;

///------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME AS BORDAS E O TITULO DO GAME ///
///------------------------------------------------------///
Procedure CABECALHO(PosX,PosY:integer);
Var
	i:integer;

	Begin
		textcolor(white);
		gotoxy(2,2); write(chr(201));
		gotoxy(31,1); write(chr(201));
		gotoxy(47,1); write(chr(187));

		for i:= 32 to 46 do
			Begin
				gotoxy(i,1); write(chr(205));
			End;

		for i:= 3 to 30 do
			Begin
				gotoxy(i,2); write(chr(205));
			End;

		write(chr(188));
		gotoxy(32,2); textcolor(12); write(' BATALHA NAVAL '); textcolor(white); write(chr(200));

		for i:= 1 to 31 do
			write(chr(205));

		write(chr(187));

		for i := 3 to 23 do
			Begin
				gotoxy(2,i); write(chr(186));
				gotoxy(79,i); write(chr(186));
			End;

		gotoxy(2,24); write(chr(200));

		for i := 3 to 78 do
			begin
				gotoxy(i,24); write(chr(205));
			End;

		write(chr(188));
		gotoxy(PosX,PosY);
	End;

///-------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME MANSAGEM DE ERROR ///
///-------------------------------------------///
Procedure ERROR;
	Begin
		gotoxy(PosX,PosY); writeln;
        textcolor(12);gotoxy(PosX,PosY+1); writeln('                 >>>> ERROR <<<<');
        gotoxy(PosX,PosY+3); writeln('     Resposta Invalida! Digite um Valor Valido');
        gotoxy(PosX,PosY+4); writeln;
        gotoxy(PosX,PosY+5); write ('        Aperte qualquer tecla para retornar ');
		readln; KeyPressed;
	End;

///---------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME O FORMATO ESCOLHIDO ///
///---------------------------------------------///
Procedure FORMATO_ESCOLHIDO (Linhas_Reais, Colunas_Reais, Numero_de_Barcos_Reais, Numero_de_Tiros_Reais: integer; var condicao:char);
	Begin
		CABECALHO(PosX,PosY);
		gotoxy(PosX,PosY); writeln('               FORMATO ESCOLHIDO: ');
		gotoxy(PosX,PosY+1); writeln;
		gotoxy(PosX,PosY+2); writeln('                 Tamanho: (',Linhas_Reais,'x',Colunas_Reais,')');
		gotoxy(PosX,PosY+3); writeln('               Numero de Barcos: ',Numero_de_Barcos_Reais);
		gotoxy(PosX,PosY+4); writeln('           Numero de Tentativas: ',Numero_de_Tiros_Reais);
		gotoxy(PosX,PosY+5); writeln;
		gotoxy(PosX,PosY+6); write('         DESEJAS USAR ESSE FORMATO (s/n)? ');
		readln(condicao);
	End;

///-----------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME UMA INTRODUCAO DE ESCOLHA DE JOGO ///
///-----------------------------------------------------------///
Procedure GAME_INF;
	Begin
		clrscr;
		CABECALHO(PosX,PosY);
		gotoxy(PosX,PosY); writeln('  INFORME COMO DESEJA SER O FORMATO DO SEU JOGO:');
		gotoxy(PosX,PosY+1); writeln;
	End;

///-------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME O PRIMEIRO MENU DO JOGO ///
///-------------------------------------------------///
Procedure PrimeiroMenu(var iniciar:char);
	Begin
		Repeat
			clrscr;
			CABECALHO(PosX,PosY);
			gotoxy(PosX,PosY); writeln('          PARA INICIAR O JOGO DIGITE 1:');
			gotoxy(PosX,PosY+3); writeln('          PARA LER O TUTORIAL DIGITE 2:');
			gotoxy(PosX+39,PosY+2); readln(iniciar);

			if iniciar = '2' then
				Begin
					clrscr;
                    CABECALHO(PosX,PosY);
                    gotoxy(5,5); write('                              TUTORIAL');
                    gotoxy(5,7); write('Nesse game de Batalha Naval o jogador se coloca na possicao de um general');
                    gotoxy(5,8); write('de gerra onde sua unica funcao e destruir navios escondidos.');
                    gotoxy(5,10); textcolor(12); write('Como jogar?');
                    gotoxy(5,12); textcolor(15); write('Escolha uma coordenada com as letras e numeros indicados e arisque um');
                    gotoxy(5,13); write('tiro, caso acerte uma embarcacao sua pontuacao almentara.');
                    gotoxy(5,14); write('Acertos consecutivos irao dar pontuacao BONUS!');
                    gotoxy(5,16); textcolor(12); write('Quando Termina o Jogo?');
                    gotoxy(5,18); textcolor(15); write('Quando o numero de TENTATIVAS chegar a 0 ou ate todas as embarcacoes');
                    gotoxy(5,19); write('serem destruidas.');
                    gotoxy(5,21); textcolor(12); write('Precione qualquer tecla para retornar ao menu anterior: ');
                    readln; KeyPressed;
				End;

			if (iniciar <> '1') and (iniciar <> '2') then
				Begin
					clrscr;
					PrimeiroMenu(iniciar);
				End;
        Until iniciar = '1';
	End;

///---------------------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA SE DESEJA JOGAR COM O FORMATO PADRAO ///
///---------------------------------------------------------------///
Procedure qualformato( var resposta:char);
	Begin
		CABECALHO(PosX,PosY);
		gotoxy(PosX,PosY); writeln('             FORMATO PADRAO ABAIXO:');
		gotoxy(PosX,PosY+1); writeln;
		gotoxy(PosX,PosY+2); writeln('                 Tamanho: (',Linhas,'x',Colunas,')');
		gotoxy(PosX,PosY+3); writeln('               Numero de Barcos: ',Numero_de_Barcos);
		gotoxy(PosX,PosY+4); writeln('           Numero de Tentativas: ',Numero_de_Tiros);
		gotoxy(PosX,PosY+6); write('   VOCE DESEJA JOGAR COM O FORMATO PADRAO (s/n)? ');
		readln(Resposta);
	End;

///-----------------------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA QUANTAS LINHAS VOCE DESEJA PARA O JOGO ///
///-----------------------------------------------------------------///
Procedure Quan_de_Linhas(var Linhas_Reais:integer; Minimo_de_Linhas,Limite_de_Linhas:integer);
	Begin
		repeat
			clrscr;
			GAME_INF;
			gotoxy(PosX,PosY+2); write('Numero de Linhas desejadas (MINIMO: ',Minimo_de_Linhas,', MAXIMO: ',Limite_de_Linhas,'): ');
			readln(Linhas_Reais);

			if (Linhas_Reais < Minimo_de_Linhas) or (Linhas_Reais > Limite_de_Linhas) then
				Begin
					clrscr;
					ERROR;
				End;

		Until (Linhas_Reais >= Minimo_de_Linhas) and (Linhas_Reais <= Limite_de_Linhas);
	End;

///------------------------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA QUANTAS COLUNAS VOCE DESEJA PARA O JOGO ///
///------------------------------------------------------------------///
Procedure Quan_de_Colunas(var Colunas_Reais:integer; Minimo_de_Colunas,Limite_de_Colunas:integer);
	Begin
		repeat
			GAME_INF;
			gotoxy(PosX,PosY+2); write('Numero de Colunas desejadas (MINIMO: ',Minimo_de_Colunas,', MAXIMO: ',Limite_de_Colunas,'): ');
			readln(Colunas_Reais);

			if (Colunas_Reais < Minimo_de_Colunas) or (Colunas_Reais > Limite_de_Colunas) then
				Begin
					clrscr;
					ERROR;
				End;
		Until (Colunas_Reais >= Minimo_de_Colunas) and (Colunas_Reais <= Limite_de_Linhas);
	End;

///---------------------------------------------------------///
/// SUBPROGRAM QUE PERGUNTA QUANTAS EMBARCACOES VOCE DESEJA ///
///---------------------------------------------------------///
Procedure Quan_de_Embarcacoes(var Numero_de_Barcos_Reais:integer; Linhas_Reais,Colunas_Reais:integer);
	Begin
		repeat
			GAME_INF;
			gotoxy(PosX,PosY+2); write('Numero de Barcos desejados (MAXIMO: ',Linhas_Reais*Colunas_Reais,'): ');
			readln(Numero_de_Barcos_Reais);

			if (Numero_de_Barcos_Reais < 1) or (Numero_de_Barcos_Reais > (Linhas_Reais*Colunas_Reais)) then
				Begin
					clrscr;
					ERROR;
				End;
		Until (Numero_de_Barcos_Reais > 0) and (Numero_de_Barcos_Reais <= (Linhas_Reais*Colunas_Reais));
	End;

///-----------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA QUANTAS LANCES VOCE DESEJA ///
///-----------------------------------------------------///
Procedure Quan_de_Tiros(var Numero_de_Tiros_Reais:integer; Linhas_Reais,Colunas_Reais:integer);
	Begin
		repeat
			GAME_INF;
			gotoxy(PosX,PosY+2); write('Numero de Tiros desejados (MAXIMO: ',Linhas_Reais*Colunas_Reais,'): ');
			readln(Numero_de_Tiros_Reais);

			if (Numero_de_Tiros_Reais < 1) or (Numero_de_Tiros_Reais > (Linhas_Reais*Colunas_Reais)) then
				Begin
					clrscr;
					ERROR;
				End;

		Until (Numero_de_Tiros_Reais > 0) and (Numero_de_Tiros_Reais <= (Linhas_Reais*Colunas_Reais));
	End;

///----------------------------------------------------///
/// SUBPROGRAMA QUE RESETA AS MATRIZES DO CAMPO MINADO ///
///----------------------------------------------------///
Procedure ResetMatriz(Linhas_Reais,Colunas_Reais:integer; var Estrutura:matriz; var navios:matrizInt);
Var
	L,C: Integer;

	Begin
		for L:= 1 to Linhas_Reais do
			for C:= 1 to Colunas_Reais do
				Begin
					Estrutura[L][C] := chr(254);
					navios[L][C] := 0;
				End;
	End;

///--------------------------------------------------------------///
/// SUBPROGRAMA QUE RESETA AS VARIAVEIS USADAS NO FINAL DO JOGO  ///
///--------------------------------------------------------------///
Procedure ZeraPlacar(var Pontuacao,Acertos_Seguidos,Pacumulada,Numero_de_Acertos,Maior_Sequencia_de_Acertos,cont:integer ; Numero_de_Tiros_Reais:integer);
	Begin
		Pontuacao := 0;
		Acertos_Seguidos := 0;
		Pacumulada := 0;
		Numero_de_Acertos := 0;
		Maior_Sequencia_de_Acertos := 0;
		cont := Numero_de_Tiros_Reais;
	End;

///--------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIME O CAMPO DE BATALHA NAVAL ///
///--------------------------------------------------///
Procedure TABELA(Colunas_Reais, Linhas_Reais:integer; Estrutura:matriz);
Var
	Pos,L,C,Alfa:integer;

	Begin
		gotoxy(6,4);

		for L:= 1 to Colunas_Reais do
			if L < 11 then
				Begin
					textbackground(Black);
					textcolor(Yellow);
					write(' ',L);
				End
			else
				Begin
					textbackground(Black);
					textcolor(Yellow);
					write(L);
				End;
		Pos := 5;
		Alfa := 65;

		for L:= 1 to Linhas_Reais do
			Begin
				gotoxy(4,Pos);
				textbackground(Black);
				textcolor(Yellow);
				write(' ',chr(Alfa));

				for C:= 1 to Colunas_Reais do
					Begin
						if Estrutura[L][C] = chr(254) then
							Begin
								textbackground(black);
								textcolor(9);
								write(' ',Estrutura[L][C]);
							End
						else if Estrutura[L][C] = chr(30) then
							Begin
								textbackground(black);
								textcolor(White);
								write(' ',Estrutura[L][C]);
							End
						else
							Begin
								textbackground(black);
								write(' ');
								textbackground(black);
								textcolor(12);
								write(Estrutura[L][C]);
							End;
					End;

				textbackground(0);
				write(' ');
				textbackground(Black);
				textcolor(Yellow);
				write(chr(Alfa),' ');
				writeln;
				Alfa := Alfa + 1;
				Pos := Pos + 1;
			End;

		gotoxy(6,Pos);

		for L:= 1 to Colunas_Reais do
			if L < 11 then
				Begin
					textbackground(Black);
					textcolor(Yellow);
					write(' ',L);
				End
			Else
				Begin
					textbackground(Black);
					textcolor(Yellow);
					write(L:2);
				End;

		textcolor(white);
		textbackground(black);
	End;

///----------------------------------------------------------------///
/// SUBPROGRAMA QUE SORTEIA ALEATORIAMENTE AS COORDENAS DOS BARCOS ///
///----------------------------------------------------------------///
Procedure RANDO(Linhas_Reais,Colunas_Reais,Numero_de_Barcos_Reais:integer; var navios:matrizInt);
var
	x,y,cont: integer;

	Begin
		cont := 0;
		Repeat
			randomize;
			x := random(Linhas_Reais)+1;
			y := random(Colunas_Reais)+1;
			if navios[x][y] = 0 then
				Begin
					navios[x][y] := 1;
					cont:= cont + 1;
				End;
		Until cont = Numero_de_Barcos_Reais;
	End;

///------------------------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIMI A QUANTIDADE DE PONTOS DENTRO DE UMA ESTRUTURA ///
///------------------------------------------------------------------------///
Procedure ShowPontos(Pontuacao:integer);
	Begin
		gotoxy(57,4); textcolor(12); write('Pontos:'); textcolor(white);
		gotoxy(55,5); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(55,6); write(chr(186)); gotoxy(60,6); textcolor(12); write(Pontuacao); textcolor(white);gotoxy(66,6); write(chr(186));
		gotoxy(55,7); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///---------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIMI UMA ESTRUTURA PARA A VARIAVEL X ///
///---------------------------------------------------------///
Procedure ShowQuadradoXY;
	Begin
		gotoxy(55,9); textcolor(12); write('Letra e Numero: Ex:[A1]'); textcolor(white);
		gotoxy(55,10); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(55,11); write(chr(186)); write('          ',chr(186));
		gotoxy(55,12); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///-------------------------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIMI UMA ESTRUTURA PARA O NUMERO DE JOGADAS RESTANTE ///
///-------------------------------------------------------------------------///
Procedure ShowChancesDeAcerto;
	Begin
		gotoxy(55,14); textcolor(12); write('Jogadas Restantes:'); textcolor(white);
		gotoxy(55,15); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(56,16); write('          ');
		gotoxy(55,16); write(chr(186)); gotoxy(60,16); textcolor(12); write(cont); textcolor(white); gotoxy(66,16); write(chr(186));
		gotoxy(55,17); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///-------------------------------------------------------------------------///
/// SUBPROGRAMA QUE IMPRIMI UMA ESTRUTURA PARA O NUMERO DE BARCOS RESTANTES ///
///-------------------------------------------------------------------------///
Procedure ShowNumeroDeBarcos (Numero_de_Barcos_Reais,Numero_de_Acertos:integer);
	Begin
		gotoxy(55,19); textcolor(12); write('Barcos Restantes:'); textcolor(white);
		gotoxy(55,20); write(chr(201),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(187));
		gotoxy(56,21); write('          ');
		gotoxy(55,21); write(chr(186)); gotoxy(60,21); textcolor(12); write(Numero_de_Barcos_Reais - Numero_de_Acertos); textcolor(white); gotoxy(66,21); write(chr(186));
		gotoxy(55,22); write(chr(200),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(205),chr(188));
	End;

///-----------------------------------------------------------------------------///
/// SUBPROGRAMA QUE VERIFICA A LETRA ESCOLHIDA ATE O USUARIO DIGITAR UMA VIAVEL ///
///-----------------------------------------------------------------------------///
Procedure LerLetra(var X:integer; Letra:char);
	Begin
		gotoxy(60,11); read(Letra);
		case upcase(Letra) of
			'A':X := 1;
			'B':X := 2;
			'C':X := 3;
			'D':X := 4;
			'E':X := 5;
			'F':X := 6;
			'G':X := 7;
			'H':X := 8;
			'I':X := 9;
			'J':X := 10;
			'K':X := 11;
			'L':X := 12;
			'M':X := 13;
			'N':X := 14;
			'O':X := 15;
			'P':X := 16;
			'Q':X := 17;
			'R':X := 18;
		Else
			Begin
				LerLetra(X,Letra);
			End;
		End;
	End;

///--------------------------------------------------------------------------///
/// SUBPROGRAMA QUE MOSTRA TODAS AS POSSICOES DOS BARCOS NO CAMPO DE BATALHA ///
///--------------------------------------------------------------------------///
Procedure RevelaMatriz(var Estrutura:matriz; Linhas_Reais,Colunas_Reais:integer; navios:matrizInt);
Var
	L,C:integer;

	Begin
		For L := 1 to Linhas_Reais do
			For C:= 1 to Colunas_Reais do
				if (navios[L][C] = 0) or (navios[L][C] = 2)  then
					Estrutura[L][C] := chr(254)
				else
					Estrutura[L][C] := chr(30);
	End;

///--------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA SE QUER JOGAR NOVAMENTE ///
///--------------------------------------------------///
Procedure ReiniciarJogo(var Perguntaultimate:char);
    Begin
		gotoxy(46,14); write('Deseja Jogar Novamente (s/n)? ');
		read(Perguntaultimate);
		case upcase(Perguntaultimate) of
			'S': Perguntaultimate := 'S';
			'N': Perguntaultimate := 'N';
		else
			Begin
				gotoxy(70,14); write('   ');
				ReiniciarJogo(Perguntaultimate);
			End;
		End;
    End;

///--------------------------------------------------------------------///
/// SUBPROGRAMA QUE PERGUNTA SE DESEJA REINICIAR COM O PADRAO ANTERIOR ///
///--------------------------------------------------------------------///
Procedure ReiniJogo(var SemiReinicio:char);
	Begin
		gotoxy(46,16); write('Deseja Jogar com o mesmo padrao');
		gotoxy(46,17); write('da Ultima Jogatina (s/n)? ');gotoxy(72,17);
		read(reini);
        case upcase(SemiReinicio) of
			'S': SemiReinicio := 'S';
			'N': SemiReinicio := 'N';
		else
			Begin
				gotoxy(72,17); write('   ');
				ReiniciarJogo(SemiReinicio);
			End;
		End;
	End;

///--------------------///
/// PROGRAMA PRINCIPAL ///
///--------------------///
Begin
	Repeat
		Repeat
			PrimeiroMenu(iniciar);
			clrscr;
			qualformato(resposta);
			if Resposta = 's' then
				Begin
					Linhas_Reais := Linhas;
					Colunas_Reais := Colunas;
					Numero_de_Barcos_Reais := Numero_de_Barcos;
					Numero_de_Tiros_Reais := Numero_de_Tiros;
					clrscr;
					FORMATO_ESCOLHIDO (Linhas_Reais, Colunas_Reais, Numero_de_Barcos_Reais, Numero_de_Tiros_Reais, condicao);
				End
			else if Resposta = 'n' then
				Begin 						Quan_de_Linhas(Linhas_Reais,Minimo_de_Linhas,Limite_de_Linhas);
					Quan_de_Colunas(Colunas_Reais,Minimo_de_Colunas,Limite_de_Colunas);
					Quan_de_Embarcacoes(Numero_de_Barcos_Reais,Linhas_Reais,Colunas_Reais);
					Quan_de_Tiros(Numero_de_Tiros_Reais,Linhas_Reais,Colunas_Reais);
					clrscr;
          			FORMATO_ESCOLHIDO (Linhas_Reais, Colunas_Reais, Numero_de_Barcos_Reais, Numero_de_Tiros_Reais, condicao);
				End
			else if (Resposta <> 's') and (Resposta <> 'n') then
				Begin
					clrscr;
					CABECALHO(PosX,PosY);
					ERROR;
					clrscr;
				End;
			clrscr;
		Until (condicao = 's');

///-----------------------------------------------------------------------------///
/// INICIA A TELA DE JOGO COM O CAMPO DE BATALHA, PONTOS E NUMERO DE TENTATIVAS ///
///-----------------------------------------------------------------------------///
		Repeat
			ResetMatriz(Linhas_Reais,Colunas_Reais,Estrutura,navios);
			CABECALHO(PosX,PosY);
			TABELA(Colunas_Reais,Linhas_Reais,Estrutura);
			ZeraPlacar(Pontuacao, Acertos_Seguidos, Pacumulada, Numero_de_Acertos, Maior_Sequencia_de_Acertos , cont, Numero_de_Tiros_Reais);
			RANDO(Linhas_Reais,Colunas_Reais,Numero_de_Barcos_Reais,navios);
			ShowQuadradoXY;
			Repeat
				ShowChancesDeAcerto;
				ShowPontos(Pontuacao);
				ShowNumeroDeBarcos(Numero_de_Barcos_Reais,Numero_de_Acertos);
				LerLetra(X,Letra);
				read(Y);
				gotoxy(60,11); write('    ');

				if (Y > 0) and (Y <= Linhas_Reais) and (X > 0) and (X <= Colunas_Reais) then
					Begin
						if navios[X][Y] = 1 then
							Begin
								Estrutura[X][Y] := chr(30);
								TABELA(Colunas_Reais,Linhas_Reais,Estrutura);
								Numero_de_Acertos := Numero_de_Acertos +1;
								Acertos_Seguidos := Acertos_Seguidos + 1;
								Pacumulada := SQR(Acertos_Seguidos);
								Pontuacao := Pontuacao + 9 + Pacumulada;
								gotoxy(40,12); textcolor(White); write('Voce acertou!  ');
								navios[X][Y] := 3;
								cont := cont - 1;
							End
						else if navios[X][Y] = 0 then
							Begin
								Acertos_Seguidos := 0;
								Estrutura[X][Y] := 'x';
								TABELA(Colunas_Reais,Linhas_Reais,Estrutura);
								gotoxy(60,20);
								navios[X][Y] := 2 ;
								gotoxy(40,12); textcolor(12); write('Voce errou!    ');
								cont := cont - 1;
							End;
					End;
			Until (cont = 0) or (Numero_de_Acertos = Numero_de_Barcos_Reais);

///-------------------------------------------------------------------------------------------------------------///
/// INICIA A TELA DE FINAL DE JOGO PARA USUARIO MOSTRANDO SUA PONTUACAO E PERGUNTANDO SE DESEJA JOGAR NOVAMENTE ///
///-------------------------------------------------------------------------------------------------------------///
			clrscr;
			RevelaMatriz(Estrutura,Linhas_Reais,Colunas_Reais,navios);
			ShowPontos(Pontuacao);
			CABECALHO(PosX,PosY);
			TABELA(Colunas_Reais,Linhas_Reais,Estrutura);
			gotoxy(47,12); textcolor(12); writeln ('GAME OVER!');
			textcolor(white);
			ReiniciarJogo(Perguntaultimate);

			if Perguntaultimate = 'S' then
				Begin
					gotoxy(45,14); write('   ');
                                        ReiniJogo(SemiReinicio);
					clrscr;
				End
			Else
				SemiReinicio := 'N';

		Until (Perguntaultimate = 'N') or (SemiReinicio = 'N');
		clrscr;
	Until (Perguntaultimate = 'N') and (SemiReinicio = 'N');

End.