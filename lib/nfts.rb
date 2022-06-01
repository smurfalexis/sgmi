import theblockchainapi from 'theblockchainapi';

let defaultClient = theblockchainapi.ApiClient.instance;
let APIKeyID = defaultClient.authentications['APIKeyID'];
let APISecretKey = defaultClient.authentications['APISecretKey'];

# BEGIN: -----------------------------------------------------------------------------------------------
# TODO:- Fill in with your own API Keys
#  Get a free API Key Pair: https://dashboard.blockchainapi.com/api-keys
APIKeyID.apiKey = 'seIHGjsENxFqvlJ';
APISecretKey.apiKey = 'G0YqhQuOaQiLKfH';
# END:   -----------------------------------------------------------------------------------------------

let apiInstance = new theblockchainapi.SolanaWalletApi();
let network = 'mainnet-beta'; 
let publicKey = '8WRsGBaDcs1X7bHWr4Ad5Nx3bW29BkcmEbyavrLXDC4i';

const result = await apiInstance.solanaGetNFTsBelongingToWallet(network, publicKey).then((data) => {
  console.log('API called successfully.');
  return data;
}, (error) => {
  console.error(error);
  return error;
});

console.log("NFTs: ", result);
