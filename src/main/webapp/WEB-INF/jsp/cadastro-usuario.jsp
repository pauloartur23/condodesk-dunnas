<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk AI | Identity</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #0F0A1F;
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
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 28px;
            padding: 40px;
            width: 450px;
            box-shadow: 0 0 50px rgba(124, 58, 237, 0.15);
        }
        h1 {
            font-size: 1.8rem;
            margin-bottom: 30px;
            background: linear-gradient(to right, #FFF, #7C3AED);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
        }
        label { font-size: 0.8rem; color: #94A3B8; letter-spacing: 1px; }
        input, select {
            width: 100%;
            padding: 12px;
            margin: 8px 0 18px 0;
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            color: white;
            box-sizing: border-box;
            transition: 0.3s;
        }
        input:focus, select:focus {
            border-color: #7C3AED;
            box-shadow: 0 0 15px rgba(124, 58, 237, 0.4);
            outline: none;
        }
        button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(45deg, #7C3AED, #4F46E5);
            border: none;
            border-radius: 10px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        button:hover {
            box-shadow: 0 0 25px rgba(124, 58, 237, 0.6);
            transform: scale(1.02);
        }
        .success-msg {
            color: #10B981;
            text-align: center;
            font-size: 0.9rem;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="glass-container">
    <h1>Provisionar Usuário</h1>
    <form action="/admin/usuarios/salvar" method="post">
        <label>NOME COMPLETO</label>
        <input type="text" name="nome" required>

        <label>E-MAIL ACADÊMICO/PROFISSIONAL</label>
        <input type="email" name="email" required>

        <label>TIPO DE ACESSO</label>
        <select name="tipo">
            <c:forEach items="${tipos}" var="t">
                <option value="${t}">${t}</option>
            </c:forEach>
        </select>

        <label>SENHA INICIAL</label>
        <input type="password" name="senha" required>

        <button type="submit">CRIAR IDENTIDADE</button>

        <c:if test="${param.sucesso == 'true'}">
            <div class="success-msg">Usuário sincronizado com a rede.</div>
        </c:if>
    </form>
</div>
</body>
</html>