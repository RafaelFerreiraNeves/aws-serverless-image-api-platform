const {
  DynamoDBClient,
  PutItemCommand
} = require("@aws-sdk/client-dynamodb");

const dynamodb = new DynamoDBClient({ region: "us-east-1" });

exports.handler = async (event) => {
  console.log(JSON.stringify(event, null, 2));

  for (const record of event.Records) {
    const fileName = record.s3.object.key;

    await dynamodb.send(
      new PutItemCommand({
        TableName: process.env.TABLE_NAME,
        Item: {
          id: {
            S: Date.now().toString()
          },
          fileName: {
            S: fileName
          }
        }
      })
    );

    console.log(`Metadata salva para ${fileName}`);
  }

  return {
    statusCode: 200
  };
};
