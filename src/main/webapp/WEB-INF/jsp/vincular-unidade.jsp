<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk AI | Matrix Mapping</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --ai-purple: #7C3AED;
            --bg-dark: #0F0A1F;
        }
        body {
            background-color: var(--bg-dark);
            background-image: radial-gradient(circle at 50% 50%, #1A1035 0%, #0F0A1F 100%);
            color: #F8FAFC;
            font-family: 'Space Grotesk', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.02);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 32px;
            padding: 50px;
            width: 500px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 35px;
            background: linear-gradient(to right, #FFF, var(--ai-purple));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-align: center;
        }
        .input-group { margin-bottom: 25px; }
        label {
            display: block;
            color: #94A3B8;
            font-size: 0.75rem;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin-bottom: 10px;
        }
        select {
            width: 100%;
            padding: 15px;
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: white;
            appearance: none;
            cursor: pointer;
            transition: 0.3s;
        }
        select:focus {
            border-color: var(--ai-purple);
            box-shadow: 0 0 15px rgba(124, 58, 237, 0.3);
            outline: none;
        }
        .btn-glow {
            width: 100%;
            padding: 18px;
            background: var(--ai-purple);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            transition: 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 15px;
        }
        .btn-glow:hover {
            background: #8B5CF6;
            box-shadow: 0 0 30px rgba(124, 58, 237, 0.5);
            transform: translateY(-2px);
        }
        .success-overlay {
            color: #10B981;
            text-align: center;
            font-size: 0.9rem;
            margin-top: 20px;
            animation: fadeIn 0.5s;
        }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    </style>
</head>
<body>
<div class="glass-card">
    <h2>Mapeamento de Ativos</h2>
    <form action="/admin/vinculos/salvar" method="post">
        <div class="input-group">
            <label>Morador / Identidade</label>
            <select name="usuarioId" required>
                <option value="" disabled selected>Selecione o usuário...</option>
                <c:forEach items="${moradores}" var="m">
                    <option value="${m.id}">${m.nome} [${m.tipo}]</option>
                </c:forEach>
            </select>
        </div>

        <div class="input-group">
            <label>Unidade Habitacional</label>
            <select name="unidadeId" required>
                <option value="" disabled selected>Selecione a unidade...</option>
                <c:forEach items="${unidades}" var="u">
                    <option value="${u.id}">Bloco ${u.bloco.identificacao} - Unidade ${u.numero}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn-glow">EFETIVAR VÍNCULO</button>

        <c:if test="${param.sucesso == 'true'}">
            <div class="success-overlay">Vínculo de unidade processado com sucesso.</div>
        </c:if>
    </form>
</div>
</body>
</html>