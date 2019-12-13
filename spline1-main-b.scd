
(

Routine.run({


	 fork{
	 	30.wait;
	 	3.do{
	 		~lowStart2_beats.play;
	 		15.wait;
	 	};

	 };

3.do{
	~lowStart1.play;
		10.wait;
	};


3.do{
~lowStart.play;
	~lowStart3_higher.play;
~lowStart2_beats.play;
		~lowStart2_beats.play;
		15.wait;
	};









~sevenLow.play;


~risingSaws.play;


});

)