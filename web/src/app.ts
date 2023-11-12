import express, { Express, Request, Response } from 'express';

const app: Express = express();

app.get('/', (req: Request, res: Response) => {
  res.send('Metaroon DevOps Example ✌ - PR 34');
});

export default app

