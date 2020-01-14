%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lINEAR REGRESSION%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compute the travel speed
travelspeed = (10./(Traveltime/60))
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
    Discomfortelsewhere,Mentaldemand,Physicaldemand,Temporaldemand,Performance,Effort,Frustration,travelspeed,...
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
    'Performance','Effort','Frustration','Travel_speed'});
 

%Data structure for R^2 and P-value
OutData=[];

%Data structure for log-likelihood
OutDataLL=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%USING TRAVEL TIME AS THE RESPONSE VARIABLE%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using all the predictors
%Define the predictor and the response variables

MaxPval=1; PvalMod=0.01;iter=0;
PvalTol=0.10;PvalModTol=0.10;

modelspecall = 'Travel_time ~ Age+Gender+Education+Occupation+Income+Marital_status+Race+Driving_experience_years+Driving_frequency+Dist_driven_per_week+Times_Evacuated+Evacuation_aids+Difficulty_evacuating+Health_rating+Vision+Hearing+Visual_disorders+Chronic_diseases+Ability_to_see_signs+Ability_to_see_speedometer+Ability_to_avoid_hitting_curbs+Ability_to_see_vehicles_coming_beside+Ability_to_brake+Ability_to_make_over_the_shoulder_check+Ability_to_make_quick_decisions+Ability_to_drive_safely+Ability_to_react_to_horns+Simulator_experience+Number_of_Lanes+Time_of_the_day+Day_of_the_week+Average_Space_Headway+Average_Time_Headway+Minimum_Space_Headway+Minimum_Time_Headway+Maximum_Space_Headway+Maximum_Time_Headway';


while and(MaxPval>PvalTol,PvalMod<PvalModTol)
    iter=iter+1;

%Build the model
LR_all = fitlm(dataset,modelspecall)
anova_LR_all = anova(LR_all,'summary')
 
PvalCoef=table2array(LR_all.Coefficients(2:end,4));
MaxPval=max(PvalCoef); PredictorMax=find(PvalCoef==MaxPval)+1;
CoefNames=LR_all.CoefficientNames;

if MaxPval>PvalTol
    CoefNames(:,PredictorMax)=[];
end;

modelspecall_Before=modelspecall;

modelspecall='Travel_time ~ ';
for i=2:length(CoefNames)
    if i<length(CoefNames)
        modelspecall=strcat(modelspecall,CoefNames(i),'+');
    else
        modelspecall=strcat(modelspecall,CoefNames(i));
    end
end;

modelspecall=modelspecall{1,1};

%Check the updated model
LR_all = fitlm(dataset,modelspecall)
anova_LR_all = anova(LR_all,'summary')
PvalMod=table2array(anova_LR_all(2,5));

if PvalMod>=PvalModTol;
    modelspecall=modelspecall_Before;
end;

display(['Iteration=', num2str(iter)]);

end;

%Extract the data afer backward elimination
LR_all = fitlm(dataset,modelspecall)
anova_LR_all = anova(LR_all,'summary')

%Get the R-squared and pValue into the datastructure created
R2val=LR_all.Rsquared.Ordinary;
Pvalue=table2array(anova_LR_all(2,5));
 
OutData=[OutData;R2val,Pvalue];
 
%Get the log-likelihood into the datastructure created
LLval=LR_all.LogLikelihood;
OutDataLL=[OutDataLL;LLval];

PvalCoef=table2array(LR_all.Coefficients(2:end,4));
Indexes=find(PvalCoef<0.10);
SigVar=LR_all.PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
model1 = SigVarOut1


%Define the predictor and the response variables
modelspecall = 'Travel_time ~ Age+Driving_frequency+Dist_driven_per_week+Difficulty_evacuating+Visual_disorders+Ability_to_make_quick_decisions+Simulator_experience+Average_Space_Headway+Minimum_Time_Headway';
%Build the model
LR_all = fitlm(dataset,modelspecall)
anova_LR_all = anova(LR_all,'summary')
 
%Get the R-squared and pValue into the datastructure created
R2val=LR_all.Rsquared.Ordinary;
Pvalue=table2array(anova_LR_all(2,5));
 
OutData=[OutData;R2val,Pvalue];
 
%Get the log-likelihood into the datastructure created
LLval=LR_all.LogLikelihood;
OutDataLL=[OutDataLL;LLval];
 
PvalCoef=table2array(LR_all.Coefficients(2:end,4));
Indexes=find(PvalCoef<0.10);
SigVar=LR_all.PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
model1 = SigVarOut1



 
allmodel = [model1 model2 model3 model4 model5 model6 model7 model8...
    model9 model10 model11 model12 model13 model14 model15...
    model16 model17 model18 model19 model20]';

