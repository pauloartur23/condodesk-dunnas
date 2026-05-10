<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk AI | Core</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #0F0A1F; /* Roxo profundo */
            color: #F8FAFC;
            font-family: 'Space Grotesk', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-image: radial-gradient(circle at 50% 50%, #1A1035 0%, #0F0A1F 100%);
        }
        .glass-container {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 40px;
            width: 400px;
            box-shadow: 0 0 40px rgba(124, 58, 237, 0.1);
        }
        h1 {
            font-size: 1.5rem;
            margin-bottom: 30px;
            background: linear-gradient(to right, #FFF, #7C3AED);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px 0;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: white;
            box-sizing: border-box;
            transition: 0.3s;
        }
        input:focus {
            border-color: #7C3AED;
            box-shadow: 0 0 10px rgba(124, 58, 237, 0.5);
            outline: none;
        }
        button {
            width: 100%;
            padding: 15px;
            background: #7C3AED;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background: #8B5CF6;
            box-shadow: 0 0 20px rgba(124, 58, 237, 0.6);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="glass-container">
    <h1>Construir Matriz de Bloco</h1>
    <form action="/admin/blocos/salvar" method="post">
        <label>NOME DO BLOCO</label>
        <input type="text" name="identificacao" placeholder="Ex: Alpha Tower" required>

        <label>NÚMERO DE ANDARES</label>
        <input type="number" name="qtdAndares" required>

        <label>UNIDADES POR ANDAR</label>
        <input type="number" name="aptosPorAndar" required>

        <button type="submit">INICIALIZAR GERAÇÃO</button>
    </form>
</div>
</body>
</html>