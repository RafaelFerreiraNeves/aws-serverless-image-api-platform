const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");

const s3 = new S3Client({ region: "us-east-1" });

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);

    const buffer = Buffer.from(body.file, "base64");

    const fileName = `image-${Date.now()}.jpg`;

    await s3.send(
      new PutObjectCommand({
        Bucket: process.env.BUCKET_NAME,
        Key: fileName,
        Body: buffer,
        ContentType: "image/jpeg"
      })
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Upload realizado",
        fileName
      })
    };
  } catch (error) {
    console.error(error);

    return {
      statusCode: 500,
      body: JSON.stringify(error)
    };
  }
};