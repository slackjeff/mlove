#!/bin/bash
#=========================HEADER==========================================|
#AUTOR
# Jefferson 'Slackjeff' Rocha <root@slackjeff.com.br>
#
#POR QUE?
# As vezes não sobra tempo para empressar o que sinto para minha amada.
# Então decidi criar este programa para automatizar minha vida e dizer
# todos os dias o que penso e sinto.
#
# Tudo é automatico, frases randomicas, imagens, desafios do dia e também
# envio para servidor.
#=========================================================================|

#========== VARIAVEIS
DATA="$(date +%d/%m/%y)"
source mlove.lst  # Carregando lib de frases
source mlovefunny.lst # Carregando lib de piadas
source mlove.conf # Carregando confs
source mlovechalenges.lst # Carregando desafios

#############################################
# FUNÇÕES
#############################################

# Cabeçalho do Documento
_head(){
	local sun_or_heart="$(( ( RANDOM % 21) + 1))"
	local IMG

	# Trocando logos conforme a variavel mandar o numero.
	if [[ "$sun_or_heart" = '1' ]]; then
		IMG="img/sun.gif"
	elif [[ "$sun_or_heart" = '2' ]]; then
		IMG="img/heart.gif"
	elif [[ "$sun_or_heart" = '3' ]]; then
		IMG="img/cloud.gif"
	elif [[ "$sun_or_heart" = '4' ]]; then
		IMG="img/bunny.gif"
	elif [[ "$sun_or_heart" = '5' ]]; then
		IMG="img/bear.gif"
	elif [[ "$sun_or_heart" = '6' ]]; then
		IMG="img/cat.gif"
	elif [[ "$sun_or_heart" = '7' ]]; then
		IMG="img/rapouse.gif"
	elif [[ "$sun_or_heart" = '8' ]]; then
		IMG="img/stitch.gif"
	elif [[ "$sun_or_heart" = '9' ]]; then
		IMG="img/poney.gif"
	elif [[ "$sun_or_heart" = '10' ]]; then
		IMG="img/poney2.gif"
	elif [[ "$sun_or_heart" = '11' ]]; then
		IMG="img/poney3.gif"
	elif [[ "$sun_or_heart" = '12' ]]; then
		IMG="img/poney4.gif"
	elif [[ "$sun_or_heart" = '13' ]]; then
		IMG="img/princess.gif"
	elif [[ "$sun_or_heart" = '14' ]]; then
		IMG="img/eyes.gif"
	elif [[ "$sun_or_heart" = '15' ]]; then
		IMG="img/ground.gif"
	elif [[ "$sun_or_heart" = '16' ]]; then
		IMG="img/ground2.gif"
	elif [[ "$sun_or_heart" = '17' ]]; then
		IMG="img/piupiu.gif"
	elif [[ "$sun_or_heart" = '18' ]]; then
		IMG="img/1.gif"
	elif [[ "$sun_or_heart" = '19' ]]; then
		IMG="img/angry.gif"
	elif [[ "$sun_or_heart" = '20' ]]; then
		IMG="img/angry1.gif"
	elif [[ "$sun_or_heart" = '21' ]]; then
		IMG="img/bird10.gif"
	fi

    cat <<EOF > index.html
<!DOCTYPE html>
<html lang="pt-br">
<head>
	<title>$PAGE_NAME</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/png" href="img/icon.jpg"/>
    <link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
	<style>
		body{background-color: white; font-size: 1.6em; margin: 0 auto;font-family: 'Mansalva', cursive;}
        h1{text-shadow: 7px 2px pink;}
        h2{text-shadow: 5px 2px pink;}
		header{
			padding: 3%;
			text-align: center;
			background-color: lightblue;
		}
		footer{text-align: center;}
		hr{border: 4px dashed lightblue;}
		.logo{width: 40%; border-radius: 50%;}
        .days{color: #ed00c3;}
        .msg{background-color: pink; padding-right: 2%; padding-left: 2%; padding-top: 5%; padding-bottom: 4%;}
	</style>
</head>
<body>
	<header>
		<h1>Bom dia $NAME!</h1>
		<img class="logo" src="$IMG"><br>
        <h2>Hoje é o dia <b class="days"><u>$DAYS</u></b> de 365 dias de mensagens.</h2>
	</header>
EOF
}

# Rodapé do documento
_footer(){
    cat <<EOF
<hr>
<footer>
<h2>Te amo... Tenha um bom dia!</h2>
</footer>
</body>
</html>
EOF
}

# Pegando frase da lista e Gerando frase
# para impressão
_GENERATE_MSG()
{
	# Pegando o total de frases existentes na biblioteca
	total_msg=${#msg[@]}
	# Pegando o total de frases existentes na biblioteca
	total_msg_funny=${#msg_funny[@]}

	# Gerando frase randomica.
	number=$(( $RANDOM % $total_msg ))

	# Qual será a frase de hoje?
	print_msg="${msg[$number]}"
	cat << EOF >> index.html
<div class="msg">
	<b>Oi amor, hoje é dia ($DATA) e a minha mensagem para você é:</b><br><br>
	$print_msg
EOF

	# Gerando frase randomica.
	number=$(( $RANDOM % $total_msg_funny ))

	# Qual será a frase de hoje?
	print_msg="${msg_funny[$number]}"
	cat << EOF >> index.html
	<p>
	<b>E a piada do dia para você dar um sorrisão é:</b><br><br>
	$print_msg
	</p>
EOF

	# Desafio, imprimir ou não? 25 então imprimimos
    chalenge="$(( ( RANDOM % 100) + 1))"
    if [[ "$chalenge" = '25' ]] || [[ "$chalenge" = '28' ]] || [[ "$chalenge" = '34' ]]; then
    	chalenge_total=${#msg_chalenges[@]}
    	# Gerando frase randomica.
		number=$(( $RANDOM % $chalenge_total ))
		print_msg="${msg_chalenges[$number]}"
		cat << EOF >> index.html
	<b>O desafio que caiu foi:</b><br><br>
	$print_msg
</div>
EOF
	else
		echo "</div>" >> index.html
    fi
}

#+++++++++++++++++++++++++++++++++++++++++++

############################################
# Iniciando processo de envio
############################################

_head >> index.html   # cabeçalho
_GENERATE_MSG         # gerando mensagem para impressão
_footer >> index.html # gerando rodapé
# Aumentando número do dia +1 de 369
TEMP_DAYS=$(( $DAYS + 1 ))
sed -i "s@DAYS=.*@DAYS="\"$TEMP_DAYS\""@" mlove.conf

# Enviando para servidor.
rsync -avzh /home/slackjeff/tati/ slackjeff@slackjeff.com.br:public_html/tati/\