# GTM Council

## Purpose

Evaluate whether a project phase is ready to go to market. Combines marketing, business, content, design, and delivery perspectives to produce a launch readiness verdict.

## Council Members

1. **Product Strategist** (Lead) - Market positioning, messaging, launch tactics, channel strategy
2. **Business Ops Lead** - Pricing validation, revenue impact, competitive positioning, risk assessment
3. **Content Reviewer** - Content accuracy verdict, SEO readiness, style compliance
4. **Design Lead** - Brand consistency, visual polish, UX coherence across surfaces
5. **Lean Delivery Lead** - MVP completeness, feature flag status, shipped vs. promised

## Activation Triggers

- Phase GTM review execution (`/gtm-review`)
- Pre-launch readiness assessment
- Marketing content overhaul
- Pricing or positioning strategy changes

## Consults Plugins

- `business-analytics` for KPI framework and financial metrics
- `content-marketing` for content strategy and competitive research

## GTM Review Template

### Phase Summary

[Phase name, features included, current completion status]

### GTM Assessment

#### Product Strategist (Lead)

- **Market Positioning**: [Is the product positioned accurately for this phase's capabilities?]
- **Messaging**: [Does the messaging match what we can deliver?]
- **Launch Tactics**: [What channels and tactics are recommended?]
- **Competitive Differentiation**: [How do we stand out for this phase?]
- **Vote**: Approve / Concern / Block
- **Rationale**: [Explanation]

#### Business Ops Lead

- **Pricing Validation**: [Is the price point justified by the current feature set?]
- **Revenue Impact**: [Expected revenue and conversion path]
- **Competitive Positioning**: [How does pricing compare to alternatives?]
- **Risk Assessment**: [What could go wrong?]
- **Vote**: Approve / Concern / Block
- **Rationale**: [Explanation]

#### Content Reviewer

- **Content Accuracy**: [Are all marketing claims accurate?]
- **SEO Readiness**: [Are meta tags, structured data, and keywords correct?]
- **Style Compliance**: [Does copy follow User-Facing Content Style rules?]
- **Misleading Claims**: [Any claims that could erode trust?]
- **Vote**: Approve / Concern / Block
- **Rationale**: [Explanation]

#### Design Lead

- **Brand Consistency**: [Is the brand experience consistent across all surfaces?]
- **Visual Polish**: [Is the UI production-ready?]
- **UX Coherence**: [Does the product experience match marketing promises?]
- **Vote**: Approve / Concern / Block
- **Rationale**: [Explanation]

#### Lean Delivery Lead

- **MVP Completeness**: [Are all planned features for this phase shipped?]
- **Feature Flags**: [Are unfinished features properly gated?]
- **Shipped vs. Promised**: [Gap analysis between marketing claims and reality]
- **Launch Timeline**: [Is the timing realistic?]
- **Vote**: Approve / Concern / Block
- **Rationale**: [Explanation]

### GTM Decision

- **Status**: Approved / Needs Changes / Blocked
- **Blocking Issues**: [Issues that must be resolved before launch]
- **Recommendations**: [Post-launch actions and follow-ups]
- **Date**: [Review date]

### Consensus Rules

- **Approved**: All members vote Approve or Concern (no Blocks)
- **Needs Changes**: One or more Concern votes on blocking items, implement recommendations
- **Blocked**: One or more Block votes, fundamental issues must be resolved before launch
