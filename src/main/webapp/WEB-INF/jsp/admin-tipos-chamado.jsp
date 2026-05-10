<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Tipos de Chamado</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active { border-left: 3px solid var(--purple); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; }
        h1 { background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 1.8rem; margin-bottom: 30px; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 30px; }
        .card h3 { color: var(--muted); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 20px; }
        label { display: block; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; margin-top: 15px; }
        input { width: 100%; padding: 12px; background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1); border-radius: 10px; color: white; font-family: inherit; }
        input:focus { border-color: var(--purple); outline: none; }
        .btn { width: 100%; padding: 14px; background: var(--purple); border: none; border-radius: 10px; color: white; font-weight: 700; cursor: pointer; margin-top: 20px; font-family: inherit; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; padding: 10px 12px; border-bottom: 1px solid var(--border); }
        td { padding: 14px 12px; font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.02); }
        .sla-badge { background: rgba(124,58,237,0.15); color: #A78BFA; padding: 4px 10px; border-radius: 8px; font-size: 0.8rem; border: 1px solid rgba(124,58,237,0.3); }
        .success { color: #10B981; margin-top: 15px; font-size: 0.9rem; }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="brand">CondoDesk AI</div>
    <a href="/dashboard" class="nav-link">📊 Dashboard</a>
    <a href="/admin/blocos/novo" class="nav-link">🏢 Estruturas</a>
    <a href="/admin/usuarios/novo" class="nav-link">👥 Usuários</a>
    <a href="/admin/vinculos/novo" class="nav-link">🔗 Mapeamento</a>
    <a href="/admin/tipos-chamado" class="nav-link active">🏷️ Tipos de Chamado</a>
    <a href="/admin/status" class="nav-link">🔄 Status</a>
    <a href="/chamados" class="nav-link">📋 Chamados</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <h1>Tipos de Chamado</h1>
    <div class="grid">
        <div class="card">
            <h3>Cadastrar Novo Tipo</h3>
            <form action="/admin/tipos-chamado/salvar" method="post">
                <label>Título do Tipo</label>
                <input type="text" name="titulo" placeholder="Ex: Manutenção Elétrica" required>
                <label>SLA (horas para resolução)</label>
                <input type="number" name="slaHoras" placeholder="Ex: 48" required min="1">
                <button type="submit" class="btn">SALVAR TIPO</button>
            </form>
            <c:if test="${param.sucesso == 'true'}">
                <p class="success">✅ Tipo cadastrado com sucesso!</p>
            </c:if>
        </div>

        <div class="card">
            <h3>Tipos Cadastrados</h3>
            <table>
                <thead>
                    <tr><th>Título</th><th>SLA</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="tipo" items="${tipos}">
                        <tr>
                            <td>${tipo.titulo}</td>
                            <td><span class="sla-badge">${tipo.slaHoras}h</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>
</body>
</html>