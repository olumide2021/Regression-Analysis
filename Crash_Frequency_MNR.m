%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%MULTINOMIAL LOGIT REGRESSION MODEL %%%%%%%%%%%%%%%%%%%%%
%Compute the travel speed
travelspeed = (10./(Traveltime/60))

Ymain = ordinal(CrashFrequency,{'1','2','3'},[],[0,5,10,15]);
newY = double(Ymain);
newY(isnan(newY))=0

%Data structure for Log-likelihood value
OutDataLL=[];
%Data structure for deviance value
OutData=[];
 
Y = ordinal(CrashFrequency);

%MODEL 1
%Create the dataset for all the dependent variables
model1 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience,...
    Timeofday,Dayofweek,Numberoflanes,AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,MinimumTimeHeadway,MaximumSpaceHeadway,MaximumTimeHeadway];
[B,dev,stats] = mnrfit(model1,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model1,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model1,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))

OutDataLL = [OutDataLL;LL];

PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases','Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns','Simulator_experience','Time_of_the_day','Day_of_the_week','Number_of_Lanes','Average_Space_Headway','Average_Time_Headway',...
    'Minimum_Space_Headway','Minimum_Time_Headway','Maximum_Space_Headway','Maximum_Time_Headway'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model1 = SigVarOut1
 
 
%MODEL 2
%Create the driver characteristics dataset
model2 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience];
[B,dev,stats] = mnrfit(model2,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model2,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model2,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases','Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns','Simulator_experience'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model2 = SigVarOut1
 
 
%MODEL 3
%Create the dataset for general participant information only
model3 = [Age,Gender,Education,Occupation,Income,Maritalstatus,Race];
[B,dev,stats] = mnrfit(model3,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model3,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model3,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model3 = SigVarOut1
 
 
%MODEL 4
%Create the dataset for driving experience
model4 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek];
[B,dev,stats] = mnrfit(model4,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model4,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model4,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Driving_experience_years','Driving_frequency','Dist_driven_per_week'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model4 = SigVarOut1
 
 
%MODEL 5
%Create the dataset for driving experience under emergency evacuation
model5 = [TimesEvacuated,Evacuationaids,Difficultyevacuating];
[B,dev,stats] = mnrfit(model5,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model5,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model5,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Times_Evacuated','Evacuation_aids','Difficulty_evacuating'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model5 = SigVarOut1
 
 
%MODEL 6
%Create the dataset for driving experience and experience under emergency 
%evacuation
model6 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating];
[B,dev,stats] = mnrfit(model6,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model6,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model6,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model6 = SigVarOut1
 
 
%MODEL 7
%Create the dataset for health-related characteristics
model7 = [Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases];
[B,dev,stats] = mnrfit(model7,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model7,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model7,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model7 = SigVarOut1
 
 
%MODEL 8
%Create the dataset for driving ability
model8 = [Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns];
[B,dev,stats] = mnrfit(model8,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model8,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model8,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model8 = SigVarOut1
 
 
%MODEL 9
%Create the dataset for experience driving the simulator
model9 = [Simulatorexperience];
[B,dev,stats] = mnrfit(model9,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model9,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model9,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Simulator_experience'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model9 = SigVarOut1
 
 
%MODEL 10
%Create the dataset for driving+emergency_evac+simulator experience 
model10 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Simulatorexperience];
[B,dev,stats] = mnrfit(model10,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model10,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model10,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Simulator_experience'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model10 = SigVarOut1
 
 
%MODEL 11
%Create the dataset for general_info+driving_experience+health-related
%information
model11 = [Age,Gender,Education,Occupation,Income,Maritalstatus,Race,...
    Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,...
    Vision,Hearing,Visualdisorders,Chronicdiseases];
[B,dev,stats] = mnrfit(model11,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model11,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model11,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model11 = SigVarOut1
 
 
%MODEL 12
%Create the dataset for number of lanes
model12 = [Numberoflanes];
[B,dev,stats] = mnrfit(model12,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model12,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model12,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Number_of_Lanes'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model12 = SigVarOut1
 
 
%MODEL 13
%Create the dataset for time of the day
model13 = [Timeofday];
[B,dev,stats] = mnrfit(model13,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model13,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model13,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Time_of_the_day'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model13 = SigVarOut1
 
 
%MODEL 14
%Create the dataset for day of the week
model14 = [Dayofweek];
[B,dev,stats] = mnrfit(model14,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model14,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model14,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Day_of_the_week'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model14 = SigVarOut1
 
 
%MODEL 15
%Create the dataset for time of the day and day of the week
model15 = [Timeofday,Dayofweek];
[B,dev,stats] = mnrfit(model15,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model15,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model15,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Time_of_the_day','Day_of_the_week'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model15 = SigVarOut1
 
 
%MODEL 16
%Create the dataset for the simulator data only
model16 = [AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,...
    MinimumTimeHeadway,MaximumSpaceHeadway,MaximumTimeHeadway];
[B,dev,stats] = mnrfit(model16,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model16,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model16,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Average_Space_Headway','Average_Time_Headway',...
    'Minimum_Space_Headway','Minimum_Time_Headway','Maximum_Space_Headway','Maximum_Time_Headway'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model16 = SigVarOut1
 
 
%MODEL 17
%Create the dataset for the average space and average time headway only
model17 = [AverageSpaceHeadway,AverageTimeHeadway];
[B,dev,stats] = mnrfit(model17,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model17,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model17,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Average_Space_Headway','Average_Time_Headway'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model17 = SigVarOut1
 
 
%MODEL 18
%Create the dataset for the minimum space and minimum time headway
model18 = [MinimumSpaceHeadway,MinimumTimeHeadway];
[B,dev,stats] = mnrfit(model18,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model18,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model18,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];

PredictorNames = {'Minimum_Space_Headway','Minimum_Time_Headway'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model18 = SigVarOut1
 
 

%MODEL 19
%Create the dataset for all the dependent variables
model19 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience,...
    Timeofday,Dayofweek,Numberoflanes,AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,MinimumTimeHeadway,...
    MaximumSpaceHeadway,MaximumTimeHeadway,travelspeed];
[B,dev,stats] = mnrfit(model19,Y,'model','ordinal');
 %To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model19,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model19,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];
PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases','Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns','Simulator_experience','Time_of_the_day','Day_of_the_week','Number_of_Lanes','Average_Space_Headway','Average_Time_Headway',...
    'Minimum_Space_Headway','Minimum_Time_Headway','Maximum_Space_Headway','Maximum_Time_Headway','travelspeed'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model19 = SigVarOut1


%MODEL 20
%Create the dataset for all the dependent variables
model20 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience,...
    Timeofday,Dayofweek,Numberoflanes,AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,MinimumTimeHeadway,...
    MaximumSpaceHeadway,MaximumTimeHeadway,travelspeed,LanePositionSD];
[B,dev,stats] = mnrfit(model20,Y,'model','ordinal');
%To compute log-likelihood
[B0,dev0,stats0] = mnrfit(model20,newY,'model','ordinal');

[pihat,dlow,hi] = mnrval(B0,model20,stats0,'model','ordinal');
pihat(isnan(pihat))=0

%Maximum achievable log likelihood 
Yhat = (newY.*log(pihat(:,1)))
Yhat(~isfinite(Yhat))=0
LL = ((sum(sum(Yhat))))
OutDataLL = [OutDataLL;LL];
 
PredictorNames = {'Age','Gender','Education','Occupation','Income','Marital_status','Race',...
    'Driving_experience_years','Driving_frequency','Dist_driven_per_week',...
    'Times_Evacuated','Evacuation_aids','Difficulty_evacuating','Health_rating','Vision',...
    'Hearing','Visual_disorders','Chronic_diseases','Ability_to_see_signs','Ability_to_see_speedometer',...
    'Ability_to_avoid_hitting_curbs','Ability_to_see_vehicles_coming_beside','Ability_to_brake',...
    'Ability_to_make_over_the_shoulder_check','Ability_to_make_quick_decisions','Ability_to_drive_safely',...
    'Ability_to_react_to_horns','Simulator_experience','Time_of_the_day','Day_of_the_week','Number_of_Lanes','Average_Space_Headway','Average_Time_Headway',...
    'Minimum_Space_Headway','Minimum_Time_Headway','Maximum_Space_Headway','Maximum_Time_Headway','travelspeed','LanePositionSD'};
 
%Get the statistical deviance into the datastructure created
devval=dev0; % Deviance value;
 
OutData=[OutData;devval];
 
PvalCoef=(stats.p(20:end,1));
Indexes=find(PvalCoef<0.10);
SigVar=PredictorNames(Indexes);
SigPval=PvalCoef(find(PvalCoef<0.10));
 
SigVarOut={};SigVarOut1={'Output: '};
for i=1:length(SigPval);
    SigVarOut{i,1}=strcat(SigVar{i},'_',num2str(SigPval(i)));
    SigVarOut1=strcat(SigVarOut1,SigVarOut{i,1},'; ');
end;
 
Model20 = SigVarOut1
allmodel = [Model1 Model2 Model3 Model4 Model5 Model6 Model7 Model8...
    Model9 Model10 Model11 Model12 Model13 Model14 Model15...
    Model16 Model17 Model18 Model19 Model20]';
%AllOutput
AOut = [OutData,OutDataLL]
