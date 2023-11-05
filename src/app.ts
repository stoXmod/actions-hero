import express, { Express, Request, Response } from 'express';

const app: Express = express();

app.get('/', (req: Request, res: Response) => {
  res.send('Metaroon DevOps Example ✌');
});

app.listen(5000, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:5000`);
});
