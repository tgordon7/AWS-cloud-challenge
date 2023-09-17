async function updateCounter() {
    try {
        let response = await fetch("https://wfq54w71jc.execute-api.us-east-1.amazonaws.com/dev");
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        let data = await response.json();
        document.getElementById("counter").textContent = `Views: ${data}`;
    } catch (error) {
        console.error("Error fetching data:", error);
        document.getElementById("counter").textContent = "Couldn't read views";
    }
}

updateCounter();