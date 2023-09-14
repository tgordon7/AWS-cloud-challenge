<script src="api.call.js"></script>
const api_url =
  "https://wfq54w71jc.execute-api.us-east-1.amazonaws.com/dev";
fetch(api_url)
  .then((response) => {
    return response.json();
  })
  .then((data) => {
    // Update the page with the visitor count from DynamoDB
    document.getElementById("read-more").innerHTML = data;
  })
  .catch(function (error) {
    // Handle any errors that occur during the request
    console.log(error);
  });