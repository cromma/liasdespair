mob/var/textspeed=4 //2 - RÁPIDO 4- MÉDIO 8- LENTO
/*
Variáveis importantes acima:
*/

mob/Interactable/
	density=1
	verb
		Interact()
			if(usr.client.color||usr.frozen)
				return
			..()

//Intro Dialogue
mob/var/jumpdialogue=0
mob/verb/jumpdialogue()
	set hidden=1
	if(!usr.talking)
		for(var/mob/Interactable/NM in get_step(src,usr.dir))
			NM.Interact(usr)
	usr.jumpdialogue=1

mob/var/talking=0
mob/proc/introdialoguebox(showtext as text,var/talkername)
	src.talking=1;talkername="Narrador:"
	winset(src,"intros.label1","text=''")
	winset(src,"intros.label2","text='[talkername]'")
	winset(src,"intros.label1","is-visible=true")
	winset(src,"intros.label2","is-visible=true")
	for(var/counter=0;counter<=lentext(showtext);++counter)
		var/texttoshow=copytext(showtext, counter,counter+1)
		var/anteriortext=winget(usr,"intros.label1","text")
		winset(src,"intros.label1","text='[anteriortext][texttoshow]'")
		sleep((textspeed/10))
	usr.jumpdialogue=0
	while(!src.jumpdialogue)
		usr<<"Aguardando pular..."
		sleep(3.5)
	winset(src,"intros.label1","is-visible=false")
	winset(src,"intros.label2","is-visible=false")
	src.jumpdialogue=0
	src.talking=0

mob/proc/showintro()
	winset(src,"intros.label1","text-color=[rgb(0,0,0)]")
	winset(src,"intros.label2","text-color=[rgb(0,0,0)]")
	winset(src,"intros.label1","is-visible=true")
	winset(src,"intros.label2","is-visible=true")
	for(var/colorcounter=0, colorcounter<255, colorcounter++)
		colorcounter+=35;var/hexcolor="[rgb(colorcounter,colorcounter,colorcounter)]"
		winset(src,"intros.label1","text-color=[hexcolor]")
		winset(src,"intros.label2","text-color=[hexcolor]")
		sleep(2)

mob/proc/hideintro()
	winset(src,"intros.label1","text-color=[rgb(255,255,255)]")
	winset(src,"intros.label2","text-color=[rgb(255,255,255)]")
	winset(src,"intros.label1","is-visible=true")
	winset(src,"intros.label2","is-visible=true")
	for(var/colorcounter=255, colorcounter>0, colorcounter--)
		colorcounter-=35;var/hexcolor="[rgb(colorcounter,colorcounter,colorcounter)]"
		winset(src,"intros.label1","text-color=[hexcolor]")
		winset(src,"intros.label2","text-color=[hexcolor]")
		sleep(2)
	winset(src,"intros.label1","is-visible=false")
	winset(src,"intros.label2","is-visible=false")

mob/proc/showgameover()
	winset(src,"gameover.label8","text-color=[rgb(0,0,0)]")
	winset(src,"gameover.label7","text-color=[rgb(0,0,0)]")
	winset(src,"gameover.label1","text-color=[rgb(0,0,0)]")
	winset(src,"gameover.label1","is-visible=true")
	var/redhex;var/redhex2
	for(var/colorcounter=0, colorcounter<255, colorcounter++)
		colorcounter+=35;var/hexcolor="[rgb(colorcounter,colorcounter,colorcounter)]"
		redhex+=0.35;redhex2+=38
		winset(src,"gameover.label8","text-color=[hexcolor]")
		winset(src,"gameover.label7","text-color=[hexcolor]")
		winset(src,"gameover.label1","text-color=[rgb(redhex2,redhex,redhex)]")
		sleep(2)

mob/proc/dialoguebox(showtext as text,var/talkername)
	src.talking=1
	winset(src,"map.label3","text=''")
	winset(src,"map.label6","text='[talkername]'")
	winset(src,"map.label3","is-visible=true")
	winset(src,"map.label6","is-visible=true")
	for(var/counter=0;counter<=lentext(showtext);++counter)
		var/texttoshow=copytext(showtext, counter,counter+1)
		var/anteriortext=winget(usr,"map.label3","text")
		winset(src,"map.label3","text='[anteriortext][texttoshow]'")
		sleep((0.9))
	usr.jumpdialogue=0
	while(!src.jumpdialogue)
		usr<<"Aguardando pular..."
		sleep(3.5)
	winset(src,"map.label6","is-visible=false")
	winset(src,"map.label3","is-visible=false")
	src.jumpdialogue=0
	src.talking=0