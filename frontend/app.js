async function upload() {
  const file = document.getElementById("fileInput").files[0];

  const reader = new FileReader();

  reader.onload = async () => {
    const base64 = reader.result.split(",")[1];

    const response = await fetch("https://dbu0l96rjl.execute-api.us-east-1.amazonaws.com/dev/upload", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        file: base64
      })
    });

    const data = await response.json();

    console.log(data);
    alert(JSON.stringify(data));
  };

  reader.readAsDataURL(file);
}
