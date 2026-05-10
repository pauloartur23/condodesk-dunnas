<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Registro</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --ai-purple: #7C3AED; }
        body {
            background: #0F0A1F; color: #F8FAFC; font-family: 'Space Grotesk', sans-serif;
            display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0;
            background-image: radial-gradient(circle at 50% 50%, #1A1035 0%, #0F0A1F 100%);
        }
        .glass-panel {
            background: rgba(255,255,255,0.02); backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1); border-radius: 32px;
            padding: 40px; width: 400px;
        }
        label { display: block; color: #94A3B8; font-size: 0.7rem; letter-spacing: 1px; margin-bottom: 6px; }
        input, select {
            width: 100%; padding: 14px; margin-bottom: 20px;
            background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1);
            border-radius: 12px; color: white; box-sizing: border-box; font-family: inherit;
        }
        select option { background: #1A1035; }
        .btn-register {
            width: 100%; padding: 18px; background: var(--ai-purple);
            border: none; border-radius: 12px; color: white; font-weight: 700; cursor: pointer;
        }
    </style>
</head>
<body>
<div class="glass-panel">
    <h2 style="text-align:center; margin-bottom:30px;">Crie sua Conta</h2>
    <form action="/registrar" method="post">
        <label>NOME COMPLETO</label>
        <input type="text" name="nome" required>

        <label>E-MAIL</label>
        <input type="email" name="email" required>

        <label>SENHA</label>
        <input type="password" name="senha" required>

        <label>TIPO DE USUÁRIO</label>
        <select name="tipo" required>
            <option value="MORADOR">Morador</option>
            <option value="COLABORADOR">Colaborador</option>
            <option value="ADMIN">Administrador</option>
        </select>

        <button type="submit" class="btn-register">FINALIZAR REGISTRO</button>
    </form>
    <p style="text-align:center; margin-top:20px; font-size:0.8rem;">
        <a href="/" style="color:#94A3B8; text-decoration:none;">Já possui conta? Voltar ao login</a>
    </p>
</div>
</body>
</html>