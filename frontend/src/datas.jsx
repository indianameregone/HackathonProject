let datas = []

async function getData() {
const url = "https://api.coinlore.net/api/tickers/";
const response = await fetch(url);
    

const json = await response.json();
for (let index = 0; index < json.data.length; index++) {
    datas.push(json.data[index])
    
}

}
getData()
export default datas