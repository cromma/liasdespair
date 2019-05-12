mob/var/movedelay=0
mob/var/frozen=0
mob/var/heartrate=2.0 //O Heart Rate indicará a velocidade em que você correrá. Quanto mais medo você tiver, mais lento você correrá, apesar de não fazer sentido algum.
mob/var/onstairs=0
mob/var/walkingsound=0
mob/Move()
	if(usr.client&&!winget(usr,"main.child1","left=map"))
		return
	if(usr.frozen)
		return
	if(usr.movedelay)
		return
	if(usr.talking)
		return
	if(usr.onstairs)
		return
	..()
	usr.movedelay=1
	if(!usr.walkingsound&&usr.client)
		usr.walkingsound=1;spawn(3.5) usr.walkingsound=0
		usr<<sound('feet.ogg')
	sleep(heartrate)
	usr.movedelay=0