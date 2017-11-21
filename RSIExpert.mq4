//+------------------------------------------------------------------+
//|                                                    RSIExpert.mq4 |
//|                               Copyright 2017, Md Nasim Al Sajjad |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
// Expert Advisor based on Relative Strength Index
// Risk Reward ratio is 1: 2
// Works in any time frame but 4Hr or Daily chart is better

#property copyright "Copyright 2017, Md Nasim Al Sajjad"
#property link      "nasimalsajjad@gmail.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
bool RSI_OverSold = false;
bool RSI_OverBought = false;

int ts1 = 0;
int tb1 = 0;
bool sells = true;
bool buys = true;
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  if (OrdersTotal()==0){
  resetKeys();
  }
  myRSISignal();
  if (RSI_OverBought== true && sells ==true){
  
  ts1 = OrderSend (_Symbol,OP_SELL,0.01,Bid ,5,Bid + 0.0075,Bid -0.0225,NULL,0,0,clrAliceBlue);

  buys = false;
   sells =false;
  }
  else if (RSI_OverSold == true && buys == true){
  
  tb1 = OrderSend(_Symbol,OP_BUY,0.01,Ask,5,Ask - 0.0075,Ask + 0.0225,NULL,0,0,clrAliceBlue);
  
  sells = false;
  buys = false;
  }
  }
  
  void resetKeys(){
  buys = true;
  sells =true;
  
  
  
  
  }
//+------------------------------------------------------------------+
void myRSISignal(){
double mRSI = iRSI(_Symbol,PERIOD_M30,14,PRICE_CLOSE,0);
if (mRSI > 80.00){
  RSI_OverBought = true;
  RSI_OverSold = false;
}else if ( mRSI < 20){
RSI_OverSold = true;
RSI_OverBought = false;
}
else{
RSI_OverBought = false;
RSI_OverSold = false;
}

}
