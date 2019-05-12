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
				usr.dialoguebox("Voc� encontrou uma bateria de fus�vel!","Lia:")
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
				usr.dialoguebox("Voc� encontrou uma bateria de fus�vel!","Lia:")
				usr.foundbaterias++
				hasfusivel=0
				return
			usr.dialoguebox("Uma vela... N�o tem nenhuma utilidade por enquanto.","Lia:")
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
			usr.dialoguebox("S�o batatas fritas. Bem fedidas por sinal.","Lia:")
	bottle4
		icon='map_objs.dmi'
		icon_state="bottle4"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor n�o encostar nisso.","Lia:")
	bottle3
		icon='map_objs.dmi'
		icon_state="bottle3"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor n�o encostar nisso.","Lia:")
	bottle2
		icon='map_objs.dmi'
		icon_state="bottle2"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor n�o encostar nisso.","Lia:")
	bottle1
		icon='map_objs.dmi'
		icon_state="bottle1"
		density=1
		Interact()
			..()
			usr.dialoguebox("... Melhor n�o encostar nisso.","Lia:")
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
					usr.dialoguebox("N�o h� energia... Por enquanto.","Lia:")
					return
				if(FS.ligado&&!hascall)
					usr.dialoguebox("Eu deveria chamar a pol�cia, mas o discador est� quebrado.","Lia:")
					return
				if(FS.ligado&&hascall)
					hascall=0
					usr.atendeutelefonema=1
					usr.dialoguebox("Voc� atende o telefonema.","")
					usr.dialoguebox("N�o � linda ? A forma que A Espiral te atrai... Ela n�o � linda ?","Voz Feminina:")
					usr.dialoguebox("Voc� viu. Voc� viu.","Voz Feminina:")
					usr.dialoguebox("N�o podemos te deixar sair daqui.","Voz Feminina:")
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
			usr.dialoguebox("Lembro-me de minha inf�ncia.","Lia:")
	manequim02
		icon='Characters.dmi'
		icon_state="Manequim2"
		density=1
		var/baterias=0
		Interact()
			..()
			usr.dialoguebox("Lembro-me de minha inf�ncia.","Lia:")
	manequim03
		icon='Characters.dmi'
		icon_state="Manequim3"
		density=1
		var/baterias=0
		Interact()
			..()
			usr.dialoguebox("Lembro-me de minha inf�ncia.","Lia:")
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
				usr.dialoguebox("Voc� colocou a primeira bateria no fus�vel.","")
				baterias++
				return
			if(usr.foundbaterias>=2&&baterias==1)
				src.overlays+=icon('map_objs.dmi',"fusivel-02")
				usr.dialoguebox("Voc� colocou a segunda bateria no fus�vel.","")
				baterias++
				return
			if(usr.foundbaterias>=3&&baterias==2)
				src.overlays+=icon('map_objs.dmi',"fusivel-03")
				usr.dialoguebox("Voc� colocou a terceira bateria no fus�vel.","")
				baterias++
				return
			if(baterias==3&&!ligado)
				usr.dialoguebox("Voc� liga o fus�vel e a energia volta a circular pela casa.","Lia:")
				ligado=1
				sleep(350)
				for(var/mob/Interactable/telefoneantigo/TA in world)
					TA.hascall=1
					TA.ringing()
				return
			if(ligado)
				usr.dialoguebox("O fus�vel j� est� funcionando.","Lia:")
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
				usr.dialoguebox("Voc� encontrou uma fita VHS.","Lia:")
				hastape=0
				return
			usr.dialoguebox("Est� vazio.","Lia:")
	armario
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			usr.dialoguebox("Est� vazio.","Lia:")
	armariofusivel1
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			if(!usr.canfindbaterias||usr.foundbaterias)
				usr.dialoguebox("Est� vazio...","Lia:")
				return
			if(!usr.foundbaterias)
				usr.dialoguebox("Voc� encontrou uma bateria!","Lia:")
				usr.foundbaterias++
				return
	armariosotaokey
		icon='map_objs.dmi'
		icon_state="cabinet"
		density=1
		Interact()
			..()
			if(!usr.sotaokey)
				usr.dialoguebox("Voc� encontrou uma chave. Ela pode ser usada no s�t�o.","Lia:")
				usr.sotaokey=1
				sleep(2.5)
				usr<<sound('ghostdoor.ogg',volume=65)
				sleep(18);usr.client.color=list(1,1,1);sleep(1.5);usr.client.color=list();usr.icon_state="Lia_Spiral";sleep(1.5);usr.client.color=list(1,1,1);sleep(1.5);usr.client.color=list();usr.icon_state="Lia"
				for(var/mob/Interactable/woodendoor/WDR in world)
					WDR.Interact()
				usr.canfindbaterias=1
				return
			else
				usr.dialoguebox("Est� vazio...","Lia:")
				return
	television
		icon='map_objs.dmi'
		icon_state="television"
		density=1
		Interact()
			..()
			for(var/mob/Interactable/fusivel/FS in world)
				if(FS.baterias<3||!FS.ligado)
					usr.dialoguebox("N�o h� energia... Por enquanto.","Lia:")
					return
				if(FS.ligado&&!usr.holdingtape)
					usr.dialoguebox("Eu n�o tenho nenhuma fita para colocar aqui.","Lia:")
					return
				if(FS.ligado&&usr.holdingtape&&usr.atendeutelefonema)
					usr.frozen=1
					usr.dialoguebox("Voc� coloca a fita VHS na televis�o. Pressione ESC para sair do v�deo.","")
					animate(usr.client,color=list(1,1,1),15,0)
					sleep(15)
					usr.client.screen+=new/obj/huds/camview
					usr.icon_state="Carrie";usr.dir=2
					usr.loc=locate(65,31,1)
					usr.frozen=0
					animate(usr.client,color=list(),15,0)
					return
				if(FS.ligado&&usr.holdingtape&&!usr.atendeutelefonema)
					usr.dialoguebox("Tenho a impress�o de que devo fazer algo antes.","Lia:")
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
				usr.dialoguebox("Eu n�o tenho tanta for�a para empurrar isso.","Lia:")
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
				usr.dialoguebox("Eu n�o tenho tanta for�a para empurrar isso.","Lia:")
	brokenglasses
		icon='map_iobjs.dmi'
		icon_state="�culos"
		density=1
		Interact()
			..()
			usr.dialoguebox("Esses �culos quebrados n�o parecem ter mais nenhuma utilidade...","Lia:")
	vela
		icon='map_iobjs.dmi'
		icon_state="vela"
		density=1
		New()
			..()
			src.overlays+=/obj/lightover/velalight
		Interact()
			..()
			usr.dialoguebox("Uma vela... N�o tem nenhuma utilidade por enquanto.","")
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
				usr.dialoguebox("Voc� percebe que a vela � uma alavanca e a puxa.","Lia:")
				return
			usr.dialoguebox("Uma vela... N�o tem nenhuma utilidade por enquanto.","Lia:")
	jaillever
		icon=null
		density=1
		Interact()
			..()
			usr.dialoguebox("Voc� puxa a alavanca escondida na parede!","")
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
			usr.dialoguebox("Mam�e n�o est� normal. N�o est� normal. N�o est�.","Anota��es:")
			del(src)
	notes02
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("Zumbidos rotacionam em meus ouvidos... Mam�e...","Anota��es:")
			del(src)
	notes03
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("A Espiral me encanta e apaixona.","Anota��es:")
			del(src)
	carriesnotes
		icon='map_objs.dmi'
		icon_state="paper"
		density=1
		Interact()
			..()
			usr.notescollected++
			usr.dialoguebox("Ah, essas s�o minhas anota��es.","Carrie:")
			usr.dialoguebox("'J� faz um bom tempo desde que toda a minha fam�lia enlouqueceu.","Anota��es de Carrie:")
			usr.dialoguebox("Eu sabia que n�s n�o dev�amos ter nos mudado para essa casa amaldi�oada.","Anota��es de Carrie:")
			usr.dialoguebox("A Espiral est� nos devorando.'","Anota��es de Carrie:")
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
				usr.dialoguebox("Esta porta est� trancada.","Lia:")
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
				usr.dialoguebox("A sa�da est� infectada pela Espiral. � melhor n�o tocar.","")
				return
			usr.dialoguebox("Por algum motivo, algu�m trancou a sa�da.","Lia:")
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
			usr.dialoguebox("Mam�e me disse para n�o sair de meu quarto...","Carrie:")
			return