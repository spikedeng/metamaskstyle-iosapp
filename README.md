# MetaMask App for SwiftUI Practice

There are 3 Pages in this demo.
Use Messari OpenAPI
https://messari.io/api/docs#operation/Get%20Asset%20Metrics

## Home page

###Dynamic Elements
1. Total amount of currencies add up
2. Currencies user owned
3. Currency prices fetched from Messari OpenApi
https://data.messari.io/api/v1/assets?fields=id,slug,symbol,metrics/market_data/price_usd

### Interactive Path
1. Tap "Add Coin" button below the TOKEN list, navilink to TOKEN Details page (related to CoinDetailsView)
2. Tap TOKEN list item, navilink to Add Coin Page (related to AddCoinView)

## Add Coin Page
### Dynamic Elements
1. Popular Assets list auto loaded when page appears. Using Messari OpenApi
https://data.messari.io/api/v1/assets/btc/metrics

### Interactive Path
1. Input asset slug like "btc", assets list displays assets only name contains input message.
2. Tap asset list item, page pops back to homepage, the currency related to the asset you just tap, appears at the bottom of the currency list.

## Coin Details Page
### Dynamic Elements
1. Currency name, total value on profile header
2. Currency operation toolbar clickable on the second button "Buy"

### Interactive Path
1. Tap the second button "Buy" on the operation toolbar. The amount of currency will increase 1 unit.
2. Click back button on the left side of navibar, pop back to homepage, and the total value of wallet gets updated


