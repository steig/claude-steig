# Quality Review - Comprehensive Code Quality and Technical Health Assessment

> ⚠️ **DEPRECATED**: This command has been merged into the unified review system. Use `/project:simone:review --type-quality` instead for comprehensive quality assessment. This command will be removed in v3.0.0.
>
> **Migration**: Use `/project:simone:review --type-quality --persona-architect --persona-security --persona-performance` instead.

Performs comprehensive analysis of code quality, technical debt, testing coverage, security posture, and overall technical health to ensure project maintainability and reliability.

## Create a TODO with EXACTLY these 8 Items

1. Parse quality review arguments and determine scope
2. Analyze code quality metrics and standards compliance  
3. Assess testing coverage and test quality
4. Review security posture and vulnerability status
5. Evaluate technical debt and maintainability
6. Examine performance and optimization opportunities
7. Generate comprehensive quality assessment report
8. Provide prioritized recommendations and improvement plan

## DETAILS on every TODO item

### 1. Parse quality review arguments and determine scope

**Arguments Format:** `[scope] [severity_filter] [format] [--flags]`

**Examples:**
- `/project:simone:quality_review` (full quality assessment)
- `/project:simone:quality_review code` (code quality focus)
- `/project:simone:quality_review security --critical` (security issues only)
- `/project:simone:quality_review technical-debt --actionable`

**Review Scopes:**
- **full**: Comprehensive quality review across all areas
- **code**: Code quality, complexity, and standards compliance
- **testing**: Test coverage, quality, and effectiveness
- **security**: Security vulnerabilities and compliance
- **technical-debt**: Technical debt analysis and prioritization
- **performance**: Performance analysis and optimization opportunities
- **maintainability**: Code maintainability and documentation quality

**Severity Filters:**
- **critical**: Critical issues requiring immediate attention
- **high**: High-priority issues affecting quality
- **medium**: Medium-priority improvements
- **low**: Low-priority enhancements
- **actionable**: Issues that can be addressed in current sprint

### 2. Analyze code quality metrics and standards compliance

**MCP INTEGRATION:** Use MCP servers for enhanced quality analysis:
- **Sequential Thinking**: Structure quality analysis systematically
- **Serena**: Enhance code analysis and pattern detection
- **GitHub**: Track quality trends and improvements over time

**Code Quality Analysis:**
```markdown
## 🔧 Code Quality Assessment

### Quality Metrics Overview
- **Overall Quality Score**: {quality_score}/100
- **Complexity Score**: {complexity_score}/100  
- **Maintainability Index**: {maintainability_index}/100
- **Code Standards Compliance**: {standards_compliance}%

### Detailed Analysis
- **Total Lines of Code**: {total_loc}
- **Average Cyclomatic Complexity**: {avg_complexity} (Target: <10)
- **Code Duplication**: {duplication_percentage}% (Target: <5%)
- **Comment Density**: {comment_density}% (Target: 10-30%)
- **Function/Method Length**: Avg {avg_function_length} lines

### Quality Issues by Severity
- 🚨 **Critical**: {critical_issues} issues
  - {critical_issue_list}
- ⚠️ **High**: {high_issues} issues  
  - {high_issue_list}
- 📝 **Medium**: {medium_issues} issues
- 💭 **Low**: {low_issues} issues
```

**Standards Compliance:**
- **Coding Standards**: Adherence to team/project coding standards
- **Naming Conventions**: Consistency in naming across codebase
- **File Organization**: Proper file structure and organization
- **Documentation Standards**: Inline documentation quality
- **API Design**: RESTful principles, GraphQL best practices

### 3. Assess testing coverage and test quality

**Testing Analysis:**
```markdown
## 🧪 Testing Quality Assessment

### Coverage Metrics
- **Overall Test Coverage**: {overall_coverage}% (Target: {coverage_target}%)
- **Line Coverage**: {line_coverage}%
- **Branch Coverage**: {branch_coverage}%
- **Function Coverage**: {function_coverage}%
- **Statement Coverage**: {statement_coverage}%

### Test Quality Indicators
- **Total Test Cases**: {total_tests}
- **Test Success Rate**: {test_success_rate}%
- **Average Test Runtime**: {avg_test_runtime}s
- **Flaky Tests**: {flaky_test_count} identified
- **Test Code Quality**: {test_quality_score}/100

### Coverage Gaps
- **Uncovered Critical Paths**: {critical_uncovered}
- **Low Coverage Components**: {low_coverage_components}
- **Missing Integration Tests**: {missing_integration}
- **Missing E2E Tests**: {missing_e2e}

### Test Types Distribution
- **Unit Tests**: {unit_test_count} ({unit_test_percentage}%)
- **Integration Tests**: {integration_test_count} ({integration_test_percentage}%)
- **End-to-End Tests**: {e2e_test_count} ({e2e_test_percentage}%)
- **Performance Tests**: {performance_test_count}
```

**Test Quality Factors:**
- **Test Completeness**: Coverage of edge cases and error conditions
- **Test Maintainability**: Test code quality and readability
- **Test Performance**: Test execution speed and efficiency
- **Test Reliability**: Consistency and stability of test results

### 4. Review security posture and vulnerability status

**Security Assessment:**
```markdown
## 🔒 Security Posture Review

### Security Score: {security_score}/100

### Vulnerability Assessment
- **Critical Vulnerabilities**: {critical_vulns}
- **High Severity**: {high_vulns}  
- **Medium Severity**: {medium_vulns}
- **Low Severity**: {low_vulns}
- **Total Security Debt**: {security_debt_hours}h estimated

### Security Categories
- **Authentication/Authorization**: {auth_score}/100
- **Input Validation**: {input_validation_score}/100
- **Data Protection**: {data_protection_score}/100
- **Infrastructure Security**: {infra_security_score}/100
- **Dependency Security**: {dependency_score}/100

### OWASP Top 10 Compliance
- ✅/❌ **A01 - Broken Access Control**: {access_control_status}
- ✅/❌ **A02 - Cryptographic Failures**: {crypto_status}
- ✅/❌ **A03 - Injection**: {injection_status}
- ✅/❌ **A04 - Insecure Design**: {design_status}
- ✅/❌ **A05 - Security Misconfiguration**: {config_status}
- ✅/❌ **A06 - Vulnerable Components**: {component_status}
- ✅/❌ **A07 - ID & Auth Failures**: {auth_failures_status}
- ✅/❌ **A08 - Software & Data Integrity**: {integrity_status}
- ✅/❌ **A09 - Security Logging**: {logging_status}
- ✅/❌ **A10 - Server-Side Request Forgery**: {ssrf_status}

### Dependencies & Supply Chain
- **Outdated Dependencies**: {outdated_deps}
- **Known Vulnerable Dependencies**: {vulnerable_deps}
- **License Compliance Issues**: {license_issues}
```

### 5. Evaluate technical debt and maintainability

**Technical Debt Analysis:**
```markdown
## 🏗️ Technical Debt Assessment

### Debt Overview
- **Total Technical Debt**: {total_debt_hours}h estimated
- **Debt Ratio**: {debt_ratio}% (Target: <15%)
- **Interest Rate**: {debt_interest}h/sprint
- **Payoff Priority Score**: {payoff_score}/100

### Debt Categories
- **Code Quality**: {code_debt_hours}h ({code_debt_percentage}%)
- **Architecture**: {arch_debt_hours}h ({arch_debt_percentage}%)
- **Documentation**: {doc_debt_hours}h ({doc_debt_percentage}%)
- **Testing**: {test_debt_hours}h ({test_debt_percentage}%)
- **Security**: {security_debt_hours}h ({security_debt_percentage}%)
- **Performance**: {perf_debt_hours}h ({perf_debt_percentage}%)

### High-Impact Debt Items
1. **{debt_item_1}**: {debt_impact_1} (Est: {debt_effort_1}h)
2. **{debt_item_2}**: {debt_impact_2} (Est: {debt_effort_2}h)
3. **{debt_item_3}**: {debt_impact_3} (Est: {debt_effort_3}h)

### Maintainability Factors
- **Code Readability**: {readability_score}/100
- **Modularity**: {modularity_score}/100
- **Documentation Coverage**: {doc_coverage}%
- **API Design Quality**: {api_quality_score}/100
```

### 6. Examine performance and optimization opportunities

**Performance Analysis:**
```markdown
## ⚡ Performance Assessment

### Performance Metrics
- **Overall Performance Score**: {performance_score}/100
- **Load Time**: {avg_load_time}ms (Target: <{load_time_target}ms)
- **Response Time**: {avg_response_time}ms (Target: <{response_target}ms)
- **Throughput**: {throughput} req/sec (Target: >{throughput_target})
- **Resource Utilization**: {resource_util}% (Target: <80%)

### Performance Bottlenecks
- **Database Queries**: {slow_queries} slow queries identified
- **Network Requests**: {network_issues} optimization opportunities
- **Memory Usage**: {memory_issues} memory leaks/inefficiencies
- **CPU Intensive Operations**: {cpu_issues} optimization targets

### Optimization Opportunities
- **Caching**: {caching_opportunities} areas for caching
- **Database**: {db_optimization_ops} query optimizations
- **Frontend**: {frontend_optimizations} UI optimizations  
- **Infrastructure**: {infra_optimizations} infrastructure improvements

### Performance Trends
- **Load Time Trend**: {load_time_trend} over last 30 days
- **Error Rate Trend**: {error_rate_trend}
- **Throughput Trend**: {throughput_trend}
```

### 7. Generate comprehensive quality assessment report

**Executive Quality Report:**
```markdown
# 📊 Quality Assessment Report

## Executive Summary
**Overall Quality Grade**: {overall_grade} | **Risk Level**: {risk_level} | **Recommended Action**: {recommended_action}

## Quality Scorecard
| Category | Score | Target | Status | Priority |
|----------|-------|--------|--------|----------|
| Code Quality | {code_score}/100 | 85+ | {code_status} | {code_priority} |
| Test Coverage | {test_score}/100 | 80+ | {test_status} | {test_priority} |
| Security | {security_score}/100 | 90+ | {security_status} | {security_priority} |
| Performance | {perf_score}/100 | 85+ | {perf_status} | {perf_priority} |
| Maintainability | {maintain_score}/100 | 80+ | {maintain_status} | {maintain_priority} |
| Documentation | {doc_score}/100 | 75+ | {doc_status} | {doc_priority} |

## Quality Trends (30 days)
- **Improving**: {improving_areas}
- **Stable**: {stable_areas}  
- **Declining**: {declining_areas}

## Critical Issues Requiring Immediate Attention
1. **{critical_issue_1}**: {critical_description_1}
2. **{critical_issue_2}**: {critical_description_2}
3. **{critical_issue_3}**: {critical_description_3}

## Quality Debt Summary
- **Total Estimated Effort**: {total_debt_effort}h
- **Quick Wins** (<4h): {quick_wins_count} items
- **Strategic Investments** (>20h): {strategic_items_count} items
- **ROI Priority**: {roi_priority_list}
```

### 8. Provide prioritized recommendations and improvement plan

**Improvement Roadmap:**
```markdown
## 💡 Quality Improvement Plan

### 🚨 Immediate Actions (This Sprint)
- [ ] **{immediate_action_1}** (Est: {effort_1}h, Impact: {impact_1})
- [ ] **{immediate_action_2}** (Est: {effort_2}h, Impact: {impact_2})
- [ ] **{immediate_action_3}** (Est: {effort_3}h, Impact: {impact_3})

### 📅 Short-term Goals (Next 2 Sprints)
- [ ] **{shortterm_goal_1}** (Est: {st_effort_1}h)
- [ ] **{shortterm_goal_2}** (Est: {st_effort_2}h)
- [ ] **{shortterm_goal_3}** (Est: {st_effort_3}h)

### 🎯 Medium-term Initiatives (Next Quarter)
- [ ] **{mediumterm_init_1}** (Est: {mt_effort_1}h)
- [ ] **{mediumterm_init_2}** (Est: {mt_effort_2}h)

### 🔄 Continuous Improvement
- [ ] **{continuous_1}**: Ongoing process improvement
- [ ] **{continuous_2}**: Regular quality monitoring
- [ ] **{continuous_3}**: Team training and best practices

## Quality Gates Recommendations

### Pre-commit Hooks
- Enable {recommended_precommit_hooks}
- Set quality thresholds: {quality_thresholds}

### CI/CD Pipeline
- Add quality gates: {pipeline_gates}
- Automated quality reporting: {auto_reporting}

### Team Practices
- Code review checklist updates: {review_checklist}
- Quality training needs: {training_needs}

## Monitoring & Metrics

### Quality Metrics to Track
- {metric_1}: Target {target_1}, Current {current_1}
- {metric_2}: Target {target_2}, Current {current_2}  
- {metric_3}: Target {target_3}, Current {current_3}

### Quality Dashboard Setup
- Real-time quality monitoring
- Trend analysis and alerts
- Team performance tracking
- Quality debt tracking

## ROI Analysis

### High-ROI Quick Wins
1. **{quick_win_1}**: {qw_roi_1} (Effort: {qw_effort_1}h)
2. **{quick_win_2}**: {qw_roi_2} (Effort: {qw_effort_2}h)

### Strategic Investments
1. **{strategic_1}**: {strategic_roi_1} (Effort: {strategic_effort_1}h)
2. **{strategic_2}**: {strategic_roi_2} (Effort: {strategic_effort_2}h)

### Risk Mitigation Priorities
- **{risk_1}**: {risk_mitigation_1}
- **{risk_2}**: {risk_mitigation_2}
```

## Quality Review Types

### Sprint Quality Review
```markdown
## 🏃 Sprint Quality Assessment
- Focus on changes made during current sprint
- Quality of new code vs existing baseline
- Test coverage for new features
- Technical debt introduced vs resolved
```

### Release Quality Review  
```markdown
## 🚀 Pre-Release Quality Gate
- Comprehensive security scan
- Performance regression testing
- Documentation completeness
- Deployment readiness assessment
```

### Quarterly Quality Audit
```markdown
## 📅 Quarterly Quality Audit
- Comprehensive quality trends analysis
- Strategic quality initiative review
- Quality process effectiveness
- Tool and practice recommendations
```

This comprehensive quality review system provides systematic assessment of all aspects of code quality while integrating with the Simone framework to track improvements and maintain high quality standards throughout the development lifecycle.