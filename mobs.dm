mob/var/notescollected=0
mob/var/sotaokey=0
mob/var/canfindbaterias=0
mob/var/foundbaterias=0
mob/var/holdingtape=0
mob/var/atendeutelefonema=0
obj/lightover
	velalight
		icon='map_objs.dmi'
		icon_state="vela-light"
		alpha=135
		layer=65

mob/Interactable
	caixacomfusivel
		icon='map_objs.dmi'
		icon_state="caixa"
		density=1
		var/hasfusivel=1
		Interact()
			..()
			if(usr.foundbaterias&&hasfusivel)
				usr.dialoguebox("Você encontrou uma bateria de fusível!","Lia:")
				usr.foundbaterias++
				hasfusivel=0
				return
			usr.dialoguebox("Uma caixa vazia e bem leve.","Lia:")
	velacomfusivel
		icon='map_iobjs.dmi'
		icon_state="vela"
		density=1
		var/hasfusivel=1
		New()
			..()
			src.overlays+=/obj/lightover/velalight
		Interact()
			..()
			if(usr.foundbaterias&&hasfusivel)
				usr.dialoguebox("Você encontrou uma bateria de fusível!","Lia:")
				usr.foundbaterias++
				hasfusivel=0
				return
			usr.dialoguebox("Uma vela... Não tem nenhuma utilidade por enquanto.","Lia:")
	mousewhite
		icon='Characters.dmi'
		icon_state="mouse_white"
		density=1
		layer=2
		heartrate=5.5
		New()
			..()
			walk_rand(src,1,1)
	mousebrown
		icon='Characters.dmi'
		icon_state="mouse_brown"
		density=1
		heartrate=5.5
		layer=2
		New()
			..()
			walk_rand(src,1,1)
	monster
		icon='Characters.dmi'
		icon_state="monster"
		density=1
		heartrate=5.5
		layer=2
		New()
			..()
			walk_rand(src,1,1)
	fries
		icon='map_objs.dmi'
		icon_state="fries"
		density=1
		Interact()
			..()
			usr.dialoguebox("São batatas fritas. Bem fedidas por sinal.","Lia:")
	bottle4
		icon='map_objs.dmi'
		icon_state="bottle4"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor não encostar nisso.","Lia:")
	bottle3
		icon='map_objs.dmi'
		icon_state="bottle3"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor não encostar nisso.","Lia:")
	bottle2
		icon='map_objs.dmi'
		icon_state="bottle2"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor não encostar nisso.","Lia:")
	bottle1
		icon='map_objs.dmi'
		icon_state="bottle1"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor não encostar nisso.","Lia:")
	telefoneantigo
		icon='map_objs.dmi'
		icon_state="red_phone"
		density=1
		var/hascall=0
		verb
			ringing()
				if(hascall)
					world<<sound('ringing.wav',volume=70,channel=4,repeat=1)
					while(hascall)
						usr<<"Aguardando..."
						sleep(2.5)
					world<<sound(null, channel=4)

		Interact()
			..()
			for(var/mob/Interactable/fusivel/FS in world)
				if(FS.baterias<3)
					usr.dialoguebox("Não há energia... Por enquanto.","Lia:")
					return
				if(FS.ligado&&!hascall)
					usr.dialoguebox("Eu deveria chamar a polícia, mas o discador está quebrado.","Lia:")
					return
				if(FS.ligado&&hascall)
					hascall=0
					usr.atendeutelefonema=1
					usr.dialoguebox("Você atende o telefonema.","")
					usr.dialoguebox("Não é linda ? A forma que A Espiral te atrai... Ela não é linda ?","Voz Feminina:")
					usr.dialoguebox("Você viu. Você viu.","Voz Feminina:")
					usr.dialoguebox("Não podemos te deixar sair daqui.","Voz Feminina:")
					usr.dialoguebox("A mulher suspende o telefonema sem dizer mais nenhuma palavra.","")
					for(var/mob/Interactable/saidadoor/SDR in world)
						SDR.icon_state="doorstorted"
						SDR.locked=1;SDR.density=1
						SDR.isdistorted=1
					return
	manequim01
		icon='Characters.dmi'
		icon_state="Manequim"
		density=1
		var/baterias=0
		Interact()
			..()
			usr.dialoguebox("Lembro-me de minha infância.","Lia:")
	manequim02
		icon='Characters.dmi'
		icon_state="Manequim2"
		density=1
		var/baterias=0
		Interact()
			..()
			usr.dialoguebox("Lembro-me de minha infância.","Lia:")
	manequim03
		icon='Characters.dmi'
		icon_state="Manequim3"
		density=1
		var/baterias=0
		Interact()
			..()
			usr.dialoguebox("Lembro-me de minha infância.","Lia:")
	fusivel
		icon='map_objs.dmi'
		icon_state="fusivel"
		density=1
		var/baterias=0
		var/ligado=0
		Interact()
			..()
			if(usr.foundbaterias>=1&&baterias==0)
				src.overlays+=icon('map_objs.dmi',"fusivel-01")
				usr.dialoguebox("Você colocou a primeira bateria no fusível.","")
				baterias++
				return
			if(usr.foundbaterias>=2&&baterias==1)
				src.overlays+=icon('map_objs.dmi',"fusivel-02")
				usr.dialoguebox("Você colocou a segunda bateria no fusível.","")
				baterias++
				return
			if(usr.foundbaterias>=3&&baterias==2)
				src.overlays+=icon('map_objs.dmi',"fusivel-03")
				usr.dialoguebox("Você colocou a terceira bateria no fusível.","")
				baterias++
				return
			if(baterias==3&&!ligado)
				usr.dialoguebox("Você liga o fusível e a energia volta a circular pela casa.","Lia:")
				ligado=1
				sleep(350)
				for(var/mob/Interactable/telefoneantigo/TA in world)
					TA.hascall=1
					TA.ringing()
				return
			if(ligado)
				usr.dialoguebox("O fusível já está funcionando.","Lia:")
				return
			usr.dialoguebox("Parece estar faltando algumas baterias...","Lia:")
			return
	armariotape
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		var/hastape=1
		Interact()
			..()
			if(hastape)
				usr.holdingtape=1
				usr.dialoguebox("Você encontrou uma fita VHS.","Lia:")
				hastape=0
				return
			usr.dialoguebox("Está vazio.","Lia:")
	armario
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			usr.dialoguebox("Está vazio.","Lia:")
	armariofusivel1
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			if(!usr.canfindbaterias||usr.foundbaterias)
				usr.dialoguebox("Está vazio...","Lia:")
				return
			if(!usr.foundbaterias)
				usr.dialoguebox("Você encontrou uma bateria!","Lia:")
				usr.foundbaterias++
				return
	armariosotaokey
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			if(!usr.sotaokey)
				usr.dialoguebox("Você encontrou uma chave. Ela pode ser usada no sótão.","Lia:")
				usr.sotaokey=1
				sleep(2.5)
				usr<<sound('ghostdoor.ogg',volume=65)
				sleep(18);usr.client.color=list(1,1,1);sleep(1.5);usr.client.color=list();usr.icon_state="Lia_Spiral";sleep(1.5);usr.client.color=list(1,1,1);sleep(1.5);usr.client.color=list();usr.icon_state="Lia"
				for(var/mob/Interactable/woodendoor/WDR in world)
					WDR.Interact()
				usr.canfindbaterias=1
				return
			else
				usr.dialoguebox("Está vazio...","Lia:")
				return
	television
		icon='map_objs.dmi'
		icon_state="television"
		density=1
		Interact()
			..()
			for(var/mob/Interactable/fusivel/FS in world)
				if(FS.baterias<3||!FS.ligado)
					usr.dialoguebox("Não há energia... Por enquanto.","Lia:")
					return
				if(FS.ligado&&!usr.holdingtape)
					usr.dialoguebox("Eu não tenho nenhuma fita para colocar aqui.","Lia:")
					return
				if(FS.ligado&&usr.holdingtape&&usr.atendeutelefonema)
					usr.frozen=1
					usr.dialoguebox("Você coloca a fita VHS na televisão. Pressione ESC para sair do vídeo.","")
					animate(usr.client,color=list(1,1,1),15,0)
					sleep(15)
					usr.client.screen+=new/obj/huds/camview
					usr.icon_state="Carrie";usr.dir=2
					usr.loc=locate(65,31,1)
					usr.frozen=0
					animate(usr.client,color=list(),15,0)
					return
				if(FS.ligado&&usr.holdingtape&&!usr.atendeutelefonema)
					usr.dialoguebox("Tenho a impressão de que devo fazer algo antes.","Lia:")
					return
			usr.dialoguebox("Parece estar sem energia.","Lia:")
	jaillock2
		icon='map_objs.dmi'
		icon_state="jail"
		density=1
		var/locked=1
		var/interacted=0
		Interact()
			..()
			if(locked)
				usr.dialoguebox("Eu não tenho tanta força para empurrar isso.","Lia:")
				interacted=1
				for(var/mob/Interactable/jaillock2/JL2 in oview(1))
					JL2.interacted=1
	jaillock
		icon='map_objs.dmi'
		icon_state="jail"
		density=1
		var/locked=1
		Interact()
			..()
			if(locked)
				usr.dialoguebox("Eu não tenho tanta força para empurrar isso.","Lia:")
	brokenglasses
		icon='map_iobjs.dmi'
		icon_state="óculos"
		density=1
		Interact()
			..()
			usr.dialoguebox("Esses óculos quebrados não parecem ter mais nenhuma utilidade...","Lia:")
	vela
		icon='map_iobjs.dmi'
		icon_state="vela"
		density=1
		New()
			..()
			src.overlays+=/obj/lightover/velalight
		Interact()
			..()
			usr.dialoguebox("Uma vela... Não tem nenhuma utilidade por enquanto.","")
	velaalavanca
		icon='map_iobjs.dmi'
		icon_state="vela"
		density=1
		New()
			..()
			src.overlays+=/obj/lightover/velalight
		Interact()
			..()
			var/returnable
			for(var/mob/Interactable/jaillock2/JL2 in world)
				if(JL2.interacted)
					JL2.locked=0
					JL2.density=0
					JL2.icon_state="jail2"
					returnable=1
			if(returnable)
				usr.dialoguebox("Você percebe que a vela é uma alavanca e a puxa.","Lia:")
				return
			usr.dialoguebox("Uma vela... Não tem nenhuma utilidade por enquanto.","Lia:")
	jaillever
		icon=null
		density=1
		Interact()
			..()
			usr.dialoguebox("Você puxa a alavanca escondida na parede!","")
			for(var/mob/Interactable/jaillock/JL in world)
				JL.locked=0
				JL.density=0
				JL.icon_state="jail2"
	notes01
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("Mamãe não está normal. Não está normal. Não está.","Anotações:")
			del(src)
	notes02
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("Zumbidos rotacionam em meus ouvidos... Mamãe...","Anotações:")
			del(src)
	notes03
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("A Espiral me encanta e apaixona.","Anotações:")
			del(src)
	carriesnotes
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("Ah, essas são minhas anotações.","Carrie:")
			usr.dialoguebox("'Já faz um bom tempo desde que toda a minha família enlouqueceu.","Anotações de Carrie:")
			usr.dialoguebox("Eu sabia que nós não devíamos ter nos mudado para essa casa amaldiçoada.","Anotações de Carrie:")
			usr.dialoguebox("A Espiral está nos devorando.'","Anotações de Carrie:")
			del(src)
	woodendoor
		icon='map_objs.dmi'
		icon_state="door"
		density=1
		layer=55
		var/locked=1
		Interact()
			..()
			if(locked)
				icon_state="door_o"
				locked=0;density=0
				return
			else
				icon_state="door"
				locked=1;density=1
				return
	sotaodoor
		icon='map_objs.dmi'
		icon_state="door"
		density=1
		layer=55
		var/locked=1
		Interact()
			..()
			if(!usr.sotaokey)
				usr.dialoguebox("Esta porta está trancada.","Lia:")
				return
			if(locked)
				icon_state="door_o"
				locked=0;density=0
				return
			else
				icon_state="door"
				locked=1;density=1
				return
	saidadoor
		icon='map_objs.dmi'
		icon_state="door"
		density=1
		layer=55
		var/locked=1
		var/isdistorted=0
		Interact()
			..()
			if(isdistorted)
				usr.dialoguebox("A saída está infectada pela Espiral. É melhor não tocar.","")
				return
			usr.dialoguebox("Por algum motivo, alguém trancou a saída.","Lia:")
			return
	saidapast
		icon='map_objs.dmi'
		icon_state="door"
		density=1
		layer=55
		var/locked=1
		var/isdistorted=0
		Interact()
			..()
			usr.dialoguebox("Mamãe me disse para não sair de meu quarto...","Carrie:")
			return