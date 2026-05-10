<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CondoDesk | Painel do Colaborador</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        :root { --purple: #7C3AED; --dark: #0F0A1F; --glass: rgba(255,255,255,0.03); --border: rgba(255,255,255,0.08); --muted: #94A3B8; }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: var(--dark); color: #F8FAFC; font-family: 'Space Grotesk', sans-serif; display: flex; min-height: 100vh; background-image: radial-gradient(circle at top right, #1A1035 0%, #0F0A1F 100%); }
        .sidebar { width: 240px; background: rgba(0,0,0,0.4); backdrop-filter: blur(20px); border-right: 1px solid var(--border); padding: 30px 20px; display: flex; flex-direction: column; }
        .brand { font-size: 1.3rem; font-weight: 700; margin-bottom: 40px; text-align: center; background: linear-gradient(to right, #FFF, var(--purple)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { display: block; padding: 12px 16px; color: var(--muted); text-decoration: none; border-radius: 10px; margin-bottom: 8px; transition: 0.2s; font-size: 0.9rem; }
        .nav-link:hover { background: var(--glass); color: #FFF; }
        .nav-link.active { border-left: 3px solid var(--purple); background: rgba(124,58,237,0.05); color: #FFF; }
        .main { flex: 1; padding: 40px 50px; overflow-y: auto; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px; }
        .badge { background: rgba(16,185,129,0.2); color: #6EE7B7; border: 1px solid #10B981; padding: 6px 16px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .card { background: var(--glass); border: 1px solid var(--border); border-radius: 20px; padding: 25px; margin-bottom: 20px; }
        .card h5 { color: var(--muted); font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; color: var(--muted); font-size: 0.75rem; text-transform: uppercase; padding: 12px 15px; border-bottom: 1px solid var(--border); }
        td { padding: 15px; font-size: 0.9rem; border-bottom: 1px solid rgba(255,255,255,0.02); }
        .status { display: inline-block; padding: 4px 10px; border-radius: 8px; font-size: 0.75rem; font-weight: 600; background: rgba(124,58,237,0.15); color: #A78BFA; border: 1px solid rgba(124,58,237,0.3); }
        .empty { text-align: center; color: var(--muted); padding: 30px; }
        .btn { display: inline-block; padding: 6px 14px; border-radius: 8px; text-decoration: none; font-size: 0.8rem; font-weight: 600; background: rgba(124,58,237,0.2); color: #A78BFA; border: 1px solid rgba(124,58,237,0.3); }
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="brand">CondoDesk</div>
    <a href="/colaborador/painel" class="nav-link active">📊 Painel</a>
    <a href="/chamados" class="nav-link">📋 Todos os Chamados</a>
    <a href="/chamados/novo" class="nav-link">➕ Novo Chamado</a>
    <a href="/logout" class="nav-link" style="color:#F87171; margin-top:40px;">🚪 Sair</a>
</aside>

<main class="main">
    <div class="header">
        <div>
            <h1 style="font-size:1.8rem;">Painel do Colaborador</h1>
            <p style="color:var(--muted); margin-top:5px;">Bem-vindo, ${usuarioLogado.nome}</p>
        </div>
        <span class="badge">COLABORADOR</span>
    </div>

    <div class="card">
        <h5>Chamados em Aberto</h5>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Unidade</th>
                    <th>Status</th>
                    <th>Data</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="chamado" items="${chamados}">
                    <tr>
                        <td style="color:var(--purple); font-weight:700;">#${chamado.id}</td>
                        <td>${chamado.titulo}</td>
                        <td style="color:var(--muted);">${chamado.unidade.bloco.identificacao} - ${chamado.unidade.numero}</td>
                        <td><span class="status">${chamado.status}</span></td>
                        <td style="color:var(--muted); font-size:0.85rem;">${chamado.dataAbertura}</td>
                        <td><a href="/chamados/${chamado.id}" class="btn">Ver detalhes</a></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty chamados}">
                    <tr><td colspan="6" class="empty">Nenhum chamado registrado.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>