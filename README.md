# AWS Serverless Image Platform

## Visão Geral

Este projeto é uma plataforma serverless de upload e processamento de imagens construída na AWS utilizando Terraform como Infrastructure as Code (IaC).

A aplicação permite que usuários enviem imagens através de uma interface web frontend. O upload é processado por uma AWS Lambda através do API Gateway, armazenado no Amazon S3 e automaticamente dispara outra função Lambda responsável por processar os metadados e armazená-los no DynamoDB.

Toda a infraestrutura é provisionada com Terraform.

---

## Arquitetura

```text
Frontend
↓
API Gateway
↓
upload_lambda
↓
Amazon S3
↓
S3 Event Trigger
↓
processor_lambda
↓
DynamoDB
↓
CloudWatch Logs
```

---

## Serviços AWS Utilizados

- AWS Lambda
- Amazon API Gateway
- Amazon S3
- Amazon DynamoDB
- Amazon CloudWatch
- AWS IAM
- Terraform

---

## Funcionalidades

- Upload de imagens via frontend
- API REST utilizando API Gateway
- Backend serverless com Lambda
- Armazenamento de arquivos no Amazon S3
- Processamento automático orientado a eventos
- Persistência de metadados no DynamoDB
- Infrastructure as Code com Terraform
- Logs e monitoramento com CloudWatch

---

## Estrutura do Projeto

```text
project/
│
├── frontend/
│   ├── index.html
│   └── app.js
│
├── lambda-upload/
│   ├── index.js
│   ├── package.json
│   └── node_modules/
│
├── lambda-processor/
│   ├── index.js
│   ├── package.json
│   └── node_modules/
│
└── terraform/
    ├── main.tf
    ├── s3.tf
    ├── iam.tf
    ├── lambda.tf
    ├── dynamodb.tf
    ├── apigateway.tf
    ├── outputs.tf
    └── destroy.yaml
```

---

## Como Funciona

1. O frontend envia uma requisição HTTP POST contendo a imagem.
2. O API Gateway recebe a requisição.
3. A upload Lambda envia a imagem para o S3.
4. O S3 dispara automaticamente a processor Lambda.
5. A processor Lambda salva os metadados da imagem no DynamoDB.
6. Os logs são gerados no CloudWatch.

---

## Pré-requisitos

- Conta AWS
- Terraform instalado
- Node.js instalado
- AWS CLI configurado
- Git instalado

---

## Outputs do Terraform

Após o deploy:

```bash
terraform output
```

Exemplo:

```text
api_url = "https://abc123.execute-api.us-east-1.amazonaws.com/dev"

bucket_name = "rafael-serverless-demo-123456789"

dynamodb_table = "images-table"
```

---

## Configurar Frontend

Edite:

```text
frontend/app.js
```

Substitua:

```javascript
YOUR_API_GATEWAY_URL
```

pela URL do API Gateway criada no deploy.

Exemplo:

```javascript
https://abc123.execute-api.us-east-1.amazonaws.com/dev
```

---

## Executando o Frontend

Abra:

```text
frontend/index.html
```

no navegador e envie uma imagem.

---

## Validando o Fluxo

### S3

As imagens enviadas devem aparecer no bucket S3.

### CloudWatch

As duas funções Lambda geram logs:

```text
/aws/lambda/upload-lambda

/aws/lambda/processor-lambda
```

### DynamoDB

Os metadados devem ser armazenados em:

```text
images-table
```

Exemplo de item:

```json
{
  "id": {
    "S": "1778356828426"
  },
  "fileName": {
    "S": "image-1778356825928.jpg"
  }
}
```

---

## Destruindo a Infraestrutura

```bash
terraform destroy
```

Se o bucket S3 não estiver vazio, configure:

```hcl
force_destroy = true
```

em:

```text
s3.tf
```

---

## CI/CD

Este projeto inclui workflows GitHub Actions para:

- Terraform Apply
- Terraform Destroy
- Automação de infraestrutura

---

## Conceitos Demonstrados

- Arquitetura Serverless
- Arquitetura Orientada a Eventos
- Infrastructure as Code
- APIs REST
- AWS Lambda
- S3 Event Notifications
- Bancos NoSQL
- Monitoramento em Cloud
- Pipelines CI/CD

---

## Autor

Rafael Ferreira Neves

---

#  Licença

Projeto desenvolvido para fins educacionais e portfólio DevOps/Cloud.

