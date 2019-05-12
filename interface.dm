mob/Login()
	..()
	src<<sound('ambience.ogg',volume=8,repeat=1)
	src.showintro()
	src.introdialoguebox("Uma garota com sérios problemas de visão acorda no porão escuro e abafado de uma casa misteriosa. Seu nome é Lia...")
	src.introdialoguebox("Abra... Abra seus olhos, Lia.")
	src.hideintro()
	world.fps=35
	client.view=2
	src.client.screen+=new/obj/huds/roundview
	//src.client.screen+=new/obj/huds/camview
	src.client.color=list(1,1,1)
	src.loc=locate(6,15,1)
	winset(src,"main.child1","left=map")
	sleep(5)
	animate(src.client,color=list(),15,0)