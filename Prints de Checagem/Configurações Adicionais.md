# Configuração do Frontend

## Obtenha a URL da API Gateway

Execute o comando:

```bash
terraform output
```

Saída esperada:

```bash
api_url = "https://dbu0l96rjl.execute-api.us-east-1.amazonaws.com/dev"
bucket_name = "rafael-serverless-demo-123456789"
dynamodb_table = "images-table"
```

---

## Edite o arquivo

```bash
frontend/app.js
```

Troque isto:

```javascript
fetch("YOUR_API_GATEWAY_URL/upload", {
```

Pela URL da sua API:

```javascript
fetch("https://dbu0l96rjl.execute-api.us-east-1.amazonaws.com/dev/upload", {
```

---

## Arquivo `app.js` completo

```javascript
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
```

---

# Testando a Aplicação

1. Salve o arquivo
2. Abra `index.html`
3. Escolha uma imagem
4. Clique em **Enviar**

---

# Resultado Esperado

Se tudo estiver correto:

- A imagem será enviada para o Amazon S3
- A Processor Lambda será executada automaticamente
- Um item será criado no DynamoDB
- Logs serão exibidos no CloudWatch