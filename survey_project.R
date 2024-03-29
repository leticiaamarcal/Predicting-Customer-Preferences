#abrir livraria
library("readr")
library("caret")
library("ggplot2")
library("lattice")
library("C50")

#upload the data
survey <- read.csv("C:/Users/letic/Desktop/CompleteResponses.csv")

#entender o dado
summary(survey)
is.na(survey)
str(survey)
is(survey)

#saber qual tipo de vari�vel � seu atributo
is(survey$elevel)
is(survey$zipcode)
is(survey$salary)
is(survey$age)
is(survey$car)
is(survey$credit)
is(survey$brand)

#entender atributos
attributes(survey$elevel)
attributes(survey$salary)
attributes(survey$zipcode)

#transformar brand em factor
survey$brand<- as.factor(survey$brand)

#ver se funcionou
is(survey$brand)

#transformar zipcode em factor
survey$zipcode<- as.factor(survey$zipcode)

#ver se funcionou
is(survey$zipcode)

#transformar cars em factor
survey$car<- as.factor(survey$car)

#ver se funcionou
is(survey$car)

#transformar elevel em factor
survey$elevel<- as.factor(survey$elevel)

#ver se funcionou
is(survey$elevel)

#agora vou train the model para ter uma vis�o melhor e depois eu recome�o o processo
#para poder otimizar

#escolher a seed
set.seed(123)

#partir o dado para poder treinar
inTrain <- createDataPartition(y = survey$brand, p = .75, list = FALSE)

#criar o train e o test
training <- survey[ inTrain,]
testing  <- survey[-inTrain,]

#checar a tamanho de cada amostra
nrow(training)
nrow(testing)

#criar cross validation
crossV <- trainControl(method = "repeatedcv", repeats = 10)

#train the model
C5treeModel <- train(brand ~ .,
                     data = training,
                     method = "C5.0Tree",
                     preProc = c("center", "scale"),
                     tuneLength = 2,
                     trControl = crossV)

#checar meu modelo (m�trica)
C5treeModel

#m�trica desse modelo
#Accuracy : 0.8469967
#Kappa : 0.6832923

#ver como o modelo priorizou cada atributo
varImp(C5treeModel)
varImp(C5treeModel, sacale=FALSE)
#mesmo resultado

#colocar o varImp dentro de um objeto pra poder plotar
plotVarimp <- varImp(C5treeModel)

#plotar varImp/ colocar param�tro para visualizar s� os que importam 
plot(plotVarimp, top=5)

#predictions com o test
Predi_Test_C5treeModel <- predict(C5treeModel, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5treeModel)

#m�tricas do test
#Accuracy : 0.9212 
#Kappa : 0.833  

#set seed
set.seed(123)

#run the model com atribute salary
C5TM_salary <- train(brand ~ salary,
                     data = training,
                     method = "C5.0Tree",
                     preProc = c("center", "scale"),
                     tuneLength = 2,
                     trControl = crossV)

#checar m�trica
#Accuracy: 0.7245956    
#Kappa: 0.4220858

#predictions com o test
Predi_Test_C5TM_salary <- predict(C5TM_salary, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_salary)

#m�trica
#Accuracy: 0.7324
#Kappa: 0.4398            

#set seed
set.seed(123)

#run the model com atribute salary, age
C5TM_salary_age <- train(brand ~ salary + age,
                         data = training,
                         method = "C5.0Tree",
                         preProc = c("center", "scale"),
                         tuneLength = 2,
                         trControl = crossV)

#checar m�trica
C5TM_salary_age

#m�tricas
#Accuracy : 0.8975057
#Kappa : 0.7841541

#predictions com o test
Predi_Test_C5TM_salary_age <- predict(C5TM_salary_age, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_salary_age)

#m�tricas
#Accuracy : 0.9244                                
#Kappa : 0.8387 

#set seed
set.seed(123)

#run the model com atribute salary, age, zipcode
C5TM_salary_age_zip <- train(brand ~ salary + age + zipcode,
                             data = training,
                             method = "C5.0Tree",
                             preProc = c("center", "scale"),
                             tuneLength = 2,
                             trControl = crossV)

#checar m�trica
C5TM_salary_age_zip

#m�tricas
#Accuracy : 0.8699009
#Kappa : 0.726712

#predictions com o test
Predi_Test_C5TM_salary_age_zip <- predict(C5TM_salary_age_zip, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_salary_age_zip)

#m�tricas
#Accuracy : 0.9228         
#Kappa : 0.8363

#set seed
set.seed(123)

#run the model com atribute salary, age, zipcode, credit
C5TM_salary_age_zip_cred <- train(brand ~ salary + age + zipcode + credit,
                                  data = training,
                                  method = "C5.0Tree",
                                  preProc = c("center", "scale"),
                                  tuneLength = 2,
                                  trControl = crossV)

#checar m�trica
C5TM_salary_age_zip_cred

#m�tricas
#Accuracy: 0.8697393   
#Kappa: 0.7263673

#predictions com o test
Predi_Test_C5TM_salary_age_zip_cred <- predict(C5TM_salary_age_zip_cred, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_salary_age_zip_cred)

#m�tricas
#Accuracy : 0.9228         
#Kappa : 0.8363  

#set seed
set.seed(123)

#run the model com atribute salary, age, zipcode, credit, car
C5TM_sa_age_zip_cred_car <- train(brand ~ salary + age + zipcode + credit + car,
                                  data = training,
                                  method = "C5.0Tree",
                                  preProc = c("center", "scale"),
                                  tuneLength = 2,
                                  trControl = crossV)

#checar m�trica
C5TM_sa_age_zip_cred_car

#m�tricas
#Accuracy: 0.8490426
#Kappa: 0.6920992    

#predictions com o test
Predi_Test_C5TM_sa_age_zip_cred_car <- predict(C5TM_sa_age_zip_cred_car, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_sa_age_zip_cred_car)

#m�tricas
#Accuracy : 0.9208          
#Kappa : 0.832 

#set seed
set.seed(123)

#run the model com atribute salary, age, zipcode, credit, car, elevel
C5TM_sa_age_zip_cred_car_e <- train(brand ~ salary + age + zipcode + credit + car + elevel,
                                    data = training,
                                    method = "C5.0Tree",
                                    preProc = c("center", "scale"),
                                    tuneLength = 2,
                                    trControl = crossV)

#checar m�trica
C5TM_sa_age_zip_cred_car_e

#m�tricas
#Accuracy: 0.847951  
#Kappa: 0.6891494 

#predictions com o test
Predi_Test_C5TM_sa_age_zip_cred_car_e <- predict(C5TM_sa_age_zip_cred_car_e, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_C5TM_sa_age_zip_cred_car_e)

#m�tricas
#Accuracy : 0.9212
#Kappa : 0.833   


#o modelo com salary e age tem a melhor m�trica

#####

#treinar modelo de Random Forest

#set the seed
set.seed(123)

#fazer o grid manualmente para a Random Forest
mtry <- expand.grid(mtry = c(1,2,3,4,5))

#train the model RF
RFmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "rf",
                                    preProc = c("center", "scale"),
                                    tuneGrid = mtry,
                                    trControl = crossV)

#checar m�trica
RFmodel

#resultado
# mtry  Accuracy    Kappa    
#  1     0.9141840  0.8179869
#  2     0.9046068  0.7972071
#  3     0.9044045  0.7967180
#  4     0.9043240  0.7965648
#  5     0.9047009  0.7974074

#Treinar de novo com o mtry=1 j� que � o que tem melhor m�trica

#set seed
set.seed(123)

#fazer o grid manualmente para a Random Forest
mtry <- expand.grid(mtry = 1)

#train the model RF
RFmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "rf",
                                    preProc = c("center", "scale"),
                                    tuneGrid = mtry,
                                    trControl = crossV)

#ver m�trica
RFmodel

#resultado
#Accuracy: 0.9142108
#Kappa: 0.8180133

#predictions com o test
Predi_Test_RFmodel <- predict(RFmodel, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_RFmodel)

#resultado no test
#Accuracy : 0.9212 
#Kappa : 0.8337 

#####

#agora vou treinar o SVM

#set seed
set.seed(123)

#fazer o grid manualmente para a SVM
NofC <- expand.grid(C=0.02)

#train the model SVM
SVMmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "svmLinear",
                                    preProc = c("center", "scale"),
                                    tuneGrid = NofC,
                                    trControl = crossV)

#ver as m�tricas
SVMmodel

#resultado
#Accuracy: 0.6217673
#Kappa: 0

#vou tentar com o tune automatico

#set seed
set.seed(123)

#train the model SVM
SVMmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "svmLinear",
                                    preProc = c("center", "scale"),
                                    tuneLength = 2,
                                    trControl = crossV)

#ver m�tricas
SVMmodel

#resultado
#Accuracy: 0.6217673
#Kappa: 0

#o resultado � o mesmo

#predictions com o test
Predi_Test_SVMmodel <- predict(SVMmodel, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_SVMmodel)

#resultado
#Accuracy: 0.6217
#Kappa: 0            

#resultado muito ruim para SVM

######

#agora vou treinar k-NN

#set seed
set.seed(123)

#fazer o grid manualmente para o k-NN
neighbor <- expand.grid(k = c(1, 3, 9, 12))

#train the model k-NN
KNNmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "knn",
                                    preProc = c("center", "scale"),
                                    tuneGrid = neighbor,
                                    trControl = crossV)

#m�tricas
KNNmodel

#k  Accuracy   Kappa    
#1  0.8963487  0.7795040
#3  0.9086202  0.8058066
#9  0.9152612  0.8202159
#12 0.9158534  0.8214452  (melhor m�trica)

#agora vou testar com o tune autom�tico

#set.seed
set.seed(123)

#train the model k-NN
KNNmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "knn",
                                    preProc = c("center", "scale"),
                                    tuneLength = 3,
                                    trControl = crossV)

#m�tricas
KNNmodel
#k  Accuracy   Kappa    
#5  0.9121897  0.8135519
#7  0.9153150  0.8202593
#9  0.9152747  0.8202457

#12 � a melhor m�trica, ent�o vai ser a que eu vou usar. vou treinar o modelo com 12
#para poder fazer as predictions

#set seed
set.seed(123)

#fazer o grid manualmente para o k-NN
neighbor <- expand.grid(k = 12)

#train the model k-NN
KNNmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "knn",
                                    preProc = c("center", "scale"),
                                    tuneGrid = neighbor,
                                    trControl = crossV)

#m�trica
#Accuracy : 0.9153819 
#Kappa : 0.8204282 

#agora vou testar o modelo

#predictions com o test
Predi_Test_KNNmodel <- predict(KNNmodel, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_KNNmodel)

#m�tricas
#Accuracy: 0.9256          
#Kappa: 0.8425    



######

#vou treinar SVM Radial

#set seed
set.seed(123)

#train the model SVM Radial 
SVMRAmodel <- train(brand ~ salary + age,
                                    data = training,
                                    method = "svmRadial",
                                    preProc = c("center", "scale"),
                                    tuneLength = 3,
                                    trControl = crossV)

#m�tricas
#C     Accuracy   Kappa    
#0.25  0.9202312  0.8305539
#0.50  0.9218742  0.8340629
#1.00  0.9227094  0.8360616

#predictions com o test
Predi_Test_SVMRAmodel <- predict(SVMRAmodel, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_SVMRAmodel)

#m�tricas
#Accuracy: 0.9232         
#Kappa: 0.8376    

####

#plotar age x salary
#quando voc� usa a fun��o ggplot, voc� abre uma caixa em branco
#por isso s� coloca a fun��o ggplot() e +, quando vc vai acrescentar
#informa��es ao seu gr�fico. voc6e usa um tipo de plot, que nesse 
#caso foi o geom_jittter. Dentro dele, voc� vai colocar o dataset
#que vai plotar (data = datasetname), a est�tica do gr�fico, usando
#a fun��o aes, omde voc� vai colocar o que fica no eixo x, e o que
#vai no eixo y. Voc� pode acrescentar um outro atributo na cor
#dos pontos. 

#criar gr�fico que mostre a rela�ao entre age e salary e que 
#mostre a lable (brand) na cor dos pontos. � poss�vel ver padr�es
ggplot() +
  geom_jitter(data = survey, aes(x = age , y = salary,
                                 color = brand))

#para saber se o modelo � bom, entender onde est�o os erros
#criou a coluna errorCL no dataset testing. Transformou todos os
#n�meros em absoluto (lembrar a tabela que fez com o Pericles).
#A brand do testing existe e diz a preferencia dos clientes. Voc�
#subtrai essa coluna pelas predictions e transforma em n�meros
#absolutos (o mesmo que colocar m�dulo). Considerar que tudo que
#for zero � acerto e tudo que for 1 � erro. Transformar em
#num�rico para fazer a subtra��o
testing$errorCL <- abs(as.numeric(testing$brand) - as.numeric(Predi_Test_SVMRAmodel))

#colocar a coluna errorCL (coluna gerada) como cor. Transformar
#em fator
ggplot() +
  geom_jitter(data = testing, aes(x = age , y = salary,
                                 color = as.factor(errorCL)))

#####

#treinar k-NN com todo os atributos para entender onde estariam os erros

#set.seed
set.seed(123)

#train the model k-NN com todos os atributos
KNNmodelAA <- train(brand ~ .,
                                    data = training,
                                    method = "knn",
                                    preProc = c("center", "scale"),
                                    tuneLength = 3,
                                    trControl = crossV)

#ver m�tricas
#k  Accuracy   Kappa     
#5  0.5504151  0.02176416
#7  0.5626870  0.03049594
#9  0.5765074  0.04709475

#predictions com o test
Predi_Test_KNNmodelAA <- predict(KNNmodelAA, testing)

#ver a accuracy no test
confusionMatrix(testing$brand, Predi_Test_KNNmodelAA)

#m�tricas
#Accuracy : 0.5974  
#Kappa : 0.0961 

#encontrar erros
testing$colunaError <- abs(as.numeric(testing$brand) - as.numeric(Predi_Test_KNNmodelAA))

#colocar a coluna errorCL (coluna gerada) como cor. Transformar
#em fator
ggplot() +
  geom_jitter(data = testing, aes(x = age , y = salary,
                                 color = as.factor(colunaError)))

#t� errando muito, mas principalmente o que � accer

####

#dei um run no knn (k=12) com salary e age e vou fazer o gr�fico
testing$colError <- abs(as.numeric(testing$brand) - as.numeric(Predi_Test_KNNmodel))


#colocar a coluna colError (coluna gerada) como cor
ggplot() +
  geom_jitter(data = testing, aes(x = age , y = salary,
                                 color = as.factor(colError)))

###

#dei um run no Single C5.0 Tree com salary e age e vou fazer o gr�fico
testing$coErrorTree <- abs(as.numeric(testing$brand) - as.numeric(Predi_Test_C5TM_salary_age))

#colocar a coluna coErrorTree (coluna gerada) como cor
ggplot() +
  geom_jitter(data = testing, aes(x = age , y = salary,
                                  color = as.factor(coErrorTree)))

#encontrando patterns
ggplot() +
  geom_jitter(data = survey, aes(x = age , y = salary,
                                  color = brand))

###

#dei um run Random Forest com salary e age e vou fazer o gr�fico
testing$errorRF <- abs(as.numeric(testing$brand) - as.numeric(Predi_Test_RFmodel))

#colocar a coluna errorRF (coluna gerada) como cor
ggplot() +
  geom_jitter(data = testing, aes(x = age , y = salary,
                                  color = as.factor(errorRF)))

###

#o modelo k-NN (k=12) foi escolhido. Agora vamos predict o dataset
#que est� incompleto

#upload the data
surveyIncomplete <- read.csv("C:/Users/letic/Desktop/SurveyIncomplete.csv")

###

#set seed
set.seed(123)

#vou fazer as previs�es
surveyIncomplete$brand <- predict(KNNmodel, surveyIncomplete)
#colcoando o data set (surveyIcomplete) e cruzando com brand, eu 
#substitui a coluna brand (que s� tinha zero) pela minha prediction.
#eu poderia criar uma coluna nova, mas o dataset ficaria com uma coluna 
#extra e seria mais dificil unir com a tabela surveyComplete. 
#a minha prediction agora � uma coluna e n�o um objeto

#ver resultado
summary(surveyIncomplete$brand)

#resultado
#0    1 
#1915 3085

set.seed(123)
#a postResample � o mesmo que o confusion matrix: voc� vai comparar
#m�tricas. Quanto o seu modelo acertou em rela��o a um dado que vc
#j� tem. Ent�o no test (uma parte do seu dado), voc� compara
#o dado que vc tem (a informa��o sobre o seu target) e aprevis�o que
#voc� fez naquele dado
#Ground Truth � a target/label
#confusion matrix d� mais informa��es que o postResample. P.e., d� o
#recall
postResample(testing$brand, pred = Predi_Test_KNNmodel)

#result
#Accuracy: 0.9223929
#Kappa: 0.8353614 

#eu quero exportar uma tabela/dataset. quero exportar o dataset
#surveyIcomplete, mas que agora est� com a coluna brand com as
#previs�es
write.csv(surveyIncomplete, file = "Survey_Pred.csv")
#Survey_Pred � o nome que eu escolhi para salvar o nome do arquivo
#para ver onde est�: getwd()
#"C:/Users/letic/Documents"

#eu quero juntar as duas tabelas e para isso usei a fun��o rbind 
#chamei a nova tabela de totalSurvey
totalSurvey <- rbind(surveyIncomplete, survey)

#checar
totalSurvey
str(totalSurvey)
summary(totalSurvey$brand)

#fazer gr�fico
ggplot() +
  geom_jitter(data = totalSurvey, aes(x = age , y = salary,
                                  color = brand))

#o gr�fico � muito parecido com o primeiro (tra�ado com o dataset
#de 10k rows, sem os outros 5k). Isso significa que as patterns
#do da dataset 10k (com as preferencias) s�o muito parecidas com os
#as patterns do dataset de 5k (onde �o temos as prefer�ncias por marca).
#por isso o modelo consegue prever t�o bem. 

ggplot() +
  geom_density(data = surveyIncomplete,aes(age), 
               fill = "red", alpha = 0.3) +
  geom_density(data = survey, aes(age), 
               fill = "blue", alpha = 0.3) +
  theme_minimal()

#####

#all the metrics:
#1-	Single C5.0 Tree - com todos os atributos (train)
#Accuracy : 0.8469967
#Kappa : 0.6832923

#Metrics test
#Accuracy : 0.9212 
#Kappa : 0.833  
---------
#2-	Single C5.0 Tree com salary (train)
#Accuracy: 0.7245956    
#Kappa: 0.4220858

#Metrics test:
#Accuracy: 0.7324
#Kappa: 0.4398            


#3-	Single C5.0 Tree com salary and age (train)

#Accuracy : 0.8975057
#Kappa : 0.7841541

#Metrics test
#Accuracy : 0.9244                                
#Kappa : 0.8387 

#4-	Single C5.0 Tree com salary, age and zipcode (train)

#Accuracy : 0.8699009
#Kappa : 0.726712

#Metrics test
#Accuracy : 0.9228         
#Kappa : 0.8363

#5-	Single C5.0 Tree com salary, age , zipcode and credit (train)

#Accuracy: 0.8697393   
#Kappa: 0.7263673

#Metrics test
#Accuracy : 0.9228         
#Kappa : 0.8363  

#6-	Single C5.0 Tree com salary, age , zipcode, credit and car (train)

#Accuracy: 0.8490426
#Kappa: 0.6920992    

#Metrics test
#Accuracy : 0.9208          
#Kappa : 0.832 
--
#7-	Random Forest with age and salary (train)

#mtry=1 
#Accuracy: 0.9142108
#Kappa: 0.8180133

#Metrics test
#Accuracy : 0.9212 
#Kappa : 0.8337 

---
#8-	SVM Linear with age and salary
#Accuracy: 0.6217673
#Kappa: 0

#Metric test
#Accuracy: 0.6217
#Kappa: 0            

--
  
#9-	K-NN with age and salary
#k = 12
#Accuracy : 0.9153819 
#Kappa : 0.8204282 

#Metrics test
#Accuracy: 0.9256          
#Kappa: 0.8425   

--
#10-	SVM Radial with age and salary
#C     Accuracy   Kappa    
#0.25  0.9202312  0.8305539
#0.50  0.9218742  0.8340629
#1.00  0.9227094  0.8360616

#Metrics test
#Accuracy: 0.9232         
#Kappa: 0.8376    
---
#11-	 K-NN com todos os atributos
#k  Accuracy   Kappa     
#5  0.5504151  0.02176416
#7  0.5626870  0.03049594
#9  0.5765074  0.04709475

#Metrics test
#Accuracy : 0.5974  
#Kappa : 0.0961 



