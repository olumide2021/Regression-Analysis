%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%GENERALIZED LINEAR REGRESSION MODEL (POISSON)%%%%%%%%%%%%%%%%%

%Data structure for Log-likelihood value
OutData=[];

%MODEL 1
%Create the dataset for all the dependent variables
model1 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience,...
    Timeofday,Dayofweek,Numberoflanes,AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,MinimumTimeHeadway,MaximumSpaceHeadway,MaximumTimeHeadway];


%Define the dependent variable
Y = Traveltime;
%Create the model using all varibales
Model1 = nbreg(model1,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model1.logL;
alphaval = Model1.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 2
%Create the driver characteristics dataset
model2 = [Age,Gender,Education,Occupation,Income,...
    Maritalstatus,Race,Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases,Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns,Simulatorexperience];
%Define the dependent variable
%Create the model using all varibales
Model2 = nbreg(model2,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model2.logL;
alphaval = Model2.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 3
%Create the dataset for general participant information only
model3 = [Age,Gender,Education,Occupation,Income,Maritalstatus,Race];
%Define the dependent variable
%Create the model using all varibales
Model3 = nbreg(model3,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model3.logL;
alphaval = Model3.alpha
% Output data
OutData=[OutData;LLval,alphaval];

%MODEL 4
%Create the dataset for driving experience
model4 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek];
%Create the model using all varibales
Model4 = nbreg(model4,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model4.logL;
alphaval = Model4.alpha
% Output data
OutData=[OutData;LLval,alphaval];

%MODEL 5
%Create the dataset for driving experience under emergency evacuation
model5 = [TimesEvacuated,Evacuationaids,Difficultyevacuating];
%Create the model using all varibales
Model5 = nbreg(model5,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model5.logL;
alphaval = Model5.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 6
%Create the dataset for driving experience and experience under emergency 
%evacuation
model6 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating];
%Define the dependent variable
%Create the model using all varibales
Model6 = nbreg(model6,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model6.logL;
alphaval = Model6.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 7
%Create the dataset for health-related characteristics
model7 = [Healthrating,Vision,Hearing,Visualdisorders,...
    Chronicdiseases];
%Define the dependent variable
%Create the model using all varibales
Model7 = nbreg(model7,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model7.logL;
alphaval = Model7.alpha
% Output data
OutData=[OutData;LLval,alphaval];



%MODEL 8
%Create the dataset for driving ability
model8 = [Abilitytoseesigns,Abilitytoseespeedometer,Abilitytoavoidhittingcurbs,...
    Abilitytoseevehiclescomingbeside,Abilitytobrake,Abilitytomakeovertheshouldercheck,...
    Abilitytomakequickdecisions,Abilitytodrivesafely,Abilitytoreacttohorns];
%Define the dependent variable
%Create the model using all varibales
Model8 = nbreg(model8,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model8.logL;
alphaval = Model8.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 9
%Create the dataset for experience driving the simulator
model9 = [Simulatorexperience];
%Define the dependent variable
%Create the model using all varibales
Model9 = nbreg(model9,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model9.logL;
alphaval = Model9.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 10
%Create the dataset for driving+emergency_evac+simulator experience 
model10 = [Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Simulatorexperience];
%Define the dependent variable
%Create the model using all varibales
Model10 = nbreg(model10,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model10.logL;
alphaval = Model10.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 11
%Create the dataset for general_info+driving_experience+health-related
%information
model11 = [Age,Gender,Education,Occupation,Income,Maritalstatus,Race,...
    Drivingexperience_years,Drivingfrequency,Distdrivenperweek,...
    TimesEvacuated,Evacuationaids,Difficultyevacuating,Healthrating,...
    Vision,Hearing,Visualdisorders,Chronicdiseases];
%Define the dependent variable
%Create the model using all varibales
Model11 = nbreg(model11,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model11.logL;
alphaval = Model11.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 12
%Create the dataset for the number of lanes
model12 = [Numberoflanes];
%Define the dependent variable
%Create the model using the variable
Model12 = nbreg(model12,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model12.logL;
alphaval = Model12.alpha
% Output data
OutData=[OutData;LLval,alphaval];

%MODEL 13
%Create the dataset for time of the day
model13 = [Timeofday];
%Define the dependent variable
%Create the model using all varibales
Model13 = nbreg(model13,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model13.logL;
alphaval = Model13.alpha
% Output data
OutData=[OutData;LLval,alphaval];



%MODEL 14
%Create the dataset for day of the week
model14 = [Dayofweek];
%Define the dependent variable
%Create the model using all varibales
Model14 = nbreg(model14,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model14.logL;
alphaval = Model14.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 15
%Create the dataset for time of the day and day of the week
model15 = [Timeofday,Dayofweek];
%Define the dependent variable
%Create the model using all varibales
Model15 = nbreg(model15,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model15.logL;
alphaval = Model15.alpha
% Output data
OutData=[OutData;LLval,alphaval];



%MODEL 16
%Create the dataset for the simulator data only
model16 = [AverageSpaceHeadway,AverageTimeHeadway,MinimumSpaceHeadway,...
    MinimumTimeHeadway,MaximumSpaceHeadway,MaximumTimeHeadway];
%Define the dependent variable
%Create the model using all varibales
Model16 = nbreg(model16,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model16.logL;
alphaval = Model16.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 17
%Create the dataset for the minimum space and minimum time headway
model17 = [AverageSpaceHeadway,AverageTimeHeadway];
%Define the dependent variable
%Create the model using all varibales
Model17 = nbreg(model17,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model17.logL;
alphaval = Model17.alpha
% Output data
OutData=[OutData;LLval,alphaval];


%MODEL 18
%Create the dataset for the minimum space and minimum time headway
model18 = [MinimumSpaceHeadway,MinimumTimeHeadway];
%Define the dependent variable
%Create the model using all varibales
Model18 = nbreg(model18,Y)

%Get the R-squared and pValue into the datastructure created
LLval = Model18.logL;
alphaval = Model18.alpha
% Output data
OutData=[OutData;LLval,alphaval];


