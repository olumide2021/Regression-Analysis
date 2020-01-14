%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%LOGISTIC REGRESSION MODEL%%%%%%%%%%%%%%%%%%%%%%%%%
 

%Create the dataset
dataset = table(Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience,...
    Timeofday,Dayofweek,Numberoflanes,Traveltime,LanePositionSD,CollsionSpeed,AverageSpaceHeadway,...
    AverageTimeHeadway,MinimumSpaceHeadway,MinimumTimeHeadway,MaximumSpaceHeadway,MaximumTimeHeadway,...
    AccelerationPedalPressure,BrakingPedalPressure,CrashFrequency,Headdiscomfort,Stomachdiscomfort,...
    Discomfortelsewhere,Mentaldemand,Physicaldemand,Temporaldemand,Performance,Effort,Frustration,BinaryCrashFrequency,...
    'VariableNames',{'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases','Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns','Simulator_experience','Time_of_the_day','Day_of_the_week','Number_of_Lanes','Travel_time',...
    'LanePositionSD','Collsion_Speed','Average_Space_Headway','Average_Time_Headway',...
    'Minimum_Space_Headway','Minimum_Time_Headway','Maximum_Space_Headway','Maximum_Time_Headway',...
    'Acceleration_Pedal_Pressure','Braking_Pedal_Pressure','Crash_Frequency'...
    'Head_discomfort','Stomach_discomfort','Discomfort_elsewhere','Mental_demand','Physical_demand','Temporal_demand',...
    'Performance','Effort','Frustration','BinaryCrashFrequency'});
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using all the predictors
%Define the predictor and the response variables
modelspec_all = 'Travel_time ~ Age+Gender+Education+Occupation+Income+Marital_status+Race+Driving_experience_years+Driving_frequency+Dist_driven_per_week+Times_Evacuated+Evacuation_aids+Difficulty_evacuating+Health_rating+Vision+Hearing+Visual_disorders+Chronic_diseases+Ability_to_see_signs+Ability_to_see_speedometer+Ability_to_avoid_hitting_curbs+Ability_to_see_vehicles_coming_beside+Ability_to_brake+Ability_to_make_over_the_shoulder_check+Ability_to_make_quick_decisions+Ability_to_drive_safely+Ability_to_react_to_horns+Simulator_experience+Number_of_Lanes+Time_of_the_day+Day_of_the_week+Average_Space_Headway+Average_Time_Headway+Minimum_Space_Headway+Minimum_Time_Headway+Maximum_Space_Headway+Maximum_Time_Headway'
Lgt_all = fitglm(dataset,modelspec_all,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using driver characteristics predictors
%Define the predictor and the response variables
modelspec_driverchar = 'Travel_time ~ Age+Gender+Education+Occupation+Income+Marital_status+Race+Driving_experience_years+Driving_frequency+Dist_driven_per_week+Times_Evacuated+Evacuation_aids+Difficulty_evacuating+Health_rating+Vision+Hearing+Visual_disorders+Chronic_diseases+Ability_to_see_signs+Ability_to_see_speedometer+Ability_to_avoid_hitting_curbs+Ability_to_see_vehicles_coming_beside+Ability_to_brake+Ability_to_make_over_the_shoulder_check+Ability_to_make_quick_decisions+Ability_to_drive_safely+Ability_to_react_to_horns+Simulator_experience'
Lgt_driverchar = fitglm(dataset,modelspec_driverchar,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using general information predictors
%Define the predictor and the response variables
modelspec_geninfo = 'Travel_time ~ Age+Gender+Education+Occupation+Income+Marital_status+Race'
Lgt_geninfo = fitglm(dataset,modelspec_geninfo,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using driving experience predictors
%Define the predictor and the response variables
modelspec_drivingexp = 'Travel_time ~ Driving_experience_years+Driving_frequency+Dist_driven_per_week'
Lgt_emergencydrivingexp = fitglm(dataset,modelspec_drivingexp,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using driving experience under emergency evacuation as predictors
%Define the predictor and the response variables
modelspec_emergencydrivingexp = 'Travel_time ~ Times_Evacuated+Evacuation_aids+Difficulty_evacuating'
Lgt_drivingexp = fitglm(dataset,modelspec_emergencydrivingexp,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using overall driving experience variables
%Define the predictor and the response variables
modelspec_overalldrivingexp = 'Travel_time ~ Times_Evacuated+Evacuation_aids+Difficulty_evacuating'
Lgt_overalldrivingexp = fitglm(dataset,modelspec_overalldrivingexp,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using health variables
%Define the predictor and the response variables
modelspec_health = 'Travel_time ~ Health_rating+Vision+Hearing+Visual_disorders+Chronic_diseases'
Lgt_health = fitglm(dataset,modelspec_health,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using driving ability variables
%Define the predictor and the response variables
modelspec_drivingability = 'Travel_time ~ Ability_to_see_signs+Ability_to_see_speedometer+Ability_to_avoid_hitting_curbs+Ability_to_see_vehicles_coming_beside+Ability_to_brake+Ability_to_make_over_the_shoulder_check+Ability_to_make_quick_decisions+Ability_to_drive_safely+Ability_to_react_to_horns'
Lgt_drivingability = fitglm(dataset,modelspec_drivingability,'Distribution','Binomial')
 
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the simulator driving experience
modelspecsimulatorexp = 'Travel_time ~ Simulator_experience';
%Build the model
LR_simexp = fitglm(dataset,modelspecsimulatorexp,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the driving, emergency driving and simulator driving experience
modelspecalldrivingexp = 'Travel_time ~ Driving_experience_years+Driving_frequency+Dist_driven_per_week+Times_Evacuated+Evacuation_aids+Difficulty_evacuating+Simulator_experience';
%Build the model
Lgt_alldrivingexp = fitglm(dataset,modelspecalldrivingexp,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the general information, driving experience and health related
%characteristics
modelspecgendrivhlth = 'Travel_time ~ Age+Gender+Education+Occupation+Income+Marital_status+Race+Driving_experience_years+Driving_frequency+Dist_driven_per_week+Health_rating+Vision+Hearing+Visual_disorders+Chronic_diseases';
%Build the model
Lgt_gendrivhlth = fitglm(dataset,modelspecgendrivhlth,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the Number of lanes
modelspecnooflanes = 'Travel_time ~ Number_of_Lanes';
%Build the model
Lgt_nooflanes = fitglm(dataset,modelspecnooflanes,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the time of the day information
modelspectime = 'Travel_time ~ Time_of_the_day';
%Build the model
Lgt_time = fitglm(dataset,modelspectime,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the day of the week
modelspecday = 'Travel_time ~ Day_of_the_week';
%Build the model
Lgt_day = fitglm(dataset,modelspecday,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using the driving condition information
modelspecdrivingcond = 'Travel_time ~ Time_of_the_day+Day_of_the_week';
%Build the model
Lgt_drivingcond = fitglm(dataset,modelspecdrivingcond,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using simulator data only
modelsimdata = 'Travel_time ~ Average_Space_Headway+Average_Time_Headway+Minimum_Space_Headway+Minimum_Time_Headway+Maximum_Space_Headway+Maximum_Time_Headway';
%Build the model
Lgt_simdata = fitglm(dataset,modelsimdata,'Distribution','Binomial')
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using average time and space headway data only
modelavheadway = 'Travel_time ~ Average_Space_Headway+Average_Time_Headway';
%Build the model
Lgt_avheadway = fitglm(dataset,modelavheadway,'Distribution','Binomial')
 
 
clc
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using minimum time and space headway data only
modelminheadway = 'Travel_time ~ Minimum_Space_Headway+Minimum_Time_Headway';
%Build the model
Lgt_minheadway = fitglm(dataset,modelminheadway,'Distribution','Binomial')
 


